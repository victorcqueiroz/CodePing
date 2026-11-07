#requires -Version 7.0
[CmdletBinding()]
param()
$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName PresentationCore, PresentationFramework, WindowsBase
$assets = Join-Path (Split-Path -Parent $PSScriptRoot) 'Assets'
$reader = [Xml.XmlReader]::Create((Join-Path $assets 'CodePingMark.xaml'))
try { $resources = [Windows.Markup.XamlReader]::Load($reader) } finally { $reader.Dispose() }
$mark = $resources['CodePingMark']
function Render-Png([int]$Width, [int]$Height, [scriptblock]$Draw) {
    $visual = [Windows.Media.DrawingVisual]::new()
    $context = $visual.RenderOpen()
    try { & $Draw $context } finally { $context.Close() }
    $bitmap = [Windows.Media.Imaging.RenderTargetBitmap]::new($Width,$Height,96,96,[Windows.Media.PixelFormats]::Pbgra32)
    $bitmap.Render($visual)
    $encoder = [Windows.Media.Imaging.PngBitmapEncoder]::new()
    $encoder.Frames.Add([Windows.Media.Imaging.BitmapFrame]::Create($bitmap))
    $stream = [IO.MemoryStream]::new()
    try { $encoder.Save($stream); return ,$stream.ToArray() } finally { $stream.Dispose() }
}
$sizes = @(16,20,24,32,40,48,64,128,256)
$frames = @($sizes | ForEach-Object {
    $size = $_
    Render-Png $size $size { param($dc) $dc.DrawImage($mark,[Windows.Rect]::new(0,0,$size,$size)) }
})
$iconStream = [IO.MemoryStream]::new()
$writer = [IO.BinaryWriter]::new($iconStream)
try {
    $writer.Write([uint16]0); $writer.Write([uint16]1); $writer.Write([uint16]$sizes.Count)
    $offset = 6 + 16 * $sizes.Count
    for ($i=0; $i -lt $sizes.Count; $i++) {
        $dimension = if ($sizes[$i] -eq 256) { 0 } else { $sizes[$i] }
        $writer.Write([byte]$dimension); $writer.Write([byte]$dimension); $writer.Write([byte]0); $writer.Write([byte]0)
        $writer.Write([uint16]1); $writer.Write([uint16]32); $writer.Write([uint32]$frames[$i].Length); $writer.Write([uint32]$offset)
        $offset += $frames[$i].Length
    }
    foreach ($frame in $frames) { $writer.Write([byte[]]$frame) }
    [IO.File]::WriteAllBytes((Join-Path $assets 'codeping.ico'),$iconStream.ToArray())
} finally { $writer.Dispose(); $iconStream.Dispose() }
[IO.File]::WriteAllBytes((Join-Path $assets 'codeping-mark.png'),(Render-Png 512 512 { param($dc) $dc.DrawImage($mark,[Windows.Rect]::new(0,0,512,512)) }))
foreach ($background in @('transparent','white')) {
    $png = Render-Png 880 224 {
        param($dc)
        if ($background -eq 'white') { $dc.DrawRectangle([Windows.Media.Brushes]::White,$null,[Windows.Rect]::new(0,0,880,224)) }
        $dc.PushTransform([Windows.Media.ScaleTransform]::new(2,2))
        $dc.DrawImage($mark,[Windows.Rect]::new(8,8,96,96))
        $typeface = [Windows.Media.Typeface]::new([Windows.Media.FontFamily]::new('Segoe UI'),[Windows.FontStyles]::Normal,[Windows.FontWeights]::SemiBold,[Windows.FontStretches]::Normal)
        $brush = [Windows.Media.SolidColorBrush]::new([Windows.Media.ColorConverter]::ConvertFromString('#192638'))
        $text = [Windows.Media.FormattedText]::new('CodePing',[Globalization.CultureInfo]::InvariantCulture,[Windows.FlowDirection]::LeftToRight,$typeface,56,$brush,1)
        $dc.DrawText($text,[Windows.Point]::new(124,18)); $dc.Pop()
    }
    $name = if ($background -eq 'white') { 'codeping-preview.png' } else { 'codeping-logo.png' }
    [IO.File]::WriteAllBytes((Join-Path $assets $name),$png)
}
Write-Host 'CodePing: SVG/XAML, PNG e ICO de 16 a 256 px.'
