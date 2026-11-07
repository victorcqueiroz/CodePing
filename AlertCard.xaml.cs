using System.Diagnostics;
using System.Windows;
using System.Windows.Threading;
using System.Windows.Interop;

namespace ClaudeAlerta;

public partial class AlertCard : Window
{
    readonly DispatcherTimer timer = new() { Interval = TimeSpan.FromMilliseconds(40) };
    readonly Stopwatch elapsed = new();
    readonly Action open, acknowledge;
    readonly SessionState session;
    readonly Preferences prefs;
    readonly string status;
    internal string SessionId { get; }
    internal AlertCard(SessionState session, string status, Preferences prefs, Action open, Action acknowledge, Action snooze)
    {
        InitializeComponent(); UiTheme.ApplyAccessibility(Resources);
        this.session = session; this.status = status; this.prefs = prefs; SessionId = session.Id; this.open = open; this.acknowledge = acknowledge;
        RefreshLanguage();
        var context = new System.Windows.Controls.ContextMenu();
        var silence = new System.Windows.Controls.MenuItem();
        silence.SetResourceReference(System.Windows.Controls.MenuItem.HeaderProperty, "Loc.Snooze");
        silence.Click += (_, _) => snooze(); context.Items.Add(silence); ContextMenu = context;
        Loaded += (_, _) =>
        {
            var handle = new WindowInteropHelper(this).Handle;
            var screen = System.Windows.Forms.Screen.FromPoint(System.Windows.Forms.Cursor.Position).WorkingArea;
            var source = HwndSource.FromHwnd(handle);
            var corner = source.CompositionTarget.TransformFromDevice.Transform(new Point(screen.Right, screen.Bottom));
            Left = corner.X - ActualWidth - 10; Top = corner.Y - ActualHeight - 10;
        };
        ContentRendered += (_, _) => { elapsed.Restart(); timer.Start(); };
        timer.Tick += (_, _) =>
        {
            double remaining = 3 - elapsed.Elapsed.TotalSeconds;
            if (remaining <= 0) { timer.Stop(); Close(); return; }
            Countdown.Text = L.F("Seconds", Math.Ceiling(remaining));
            TimeScale.ScaleX = SystemParameters.ClientAreaAnimation ? remaining / 3 : 1;
        };
        Closed += (_, _) => { timer.Stop(); elapsed.Stop(); };
    }
    internal void RefreshLanguage()
    {
        Language = System.Windows.Markup.XmlLanguage.GetLanguage(L.Current);
        AlertTitle.Text = L.Status(status); AlertTitle.ToolTip = AlertTitle.Text;
        ProjectLabel.Text = SessionId == "demo" ? L.T("ExampleProject") : prefs.ProjectName(session);
        ProjectLabel.ToolTip = ProjectLabel.Text;
        ConversationLabel.Text = L.F("ConversationLabel", SessionId == "demo" ? L.T("ExampleConversation") : prefs.ConversationName(session));
        ConversationLabel.ToolTip = ConversationLabel.Text + "\n" + L.F("SessionIdentifier", SessionId);
        DeferToastButton.Visibility = status is "Resposta concluída" or "Claude interrompido por erro" || SessionId == "demo" ? Visibility.Collapsed : Visibility.Visible;
        Countdown.Text = L.F("Seconds", Math.Max(1, Math.Ceiling(3 - elapsed.Elapsed.TotalSeconds)));
    }
    void Open_Click(object sender, RoutedEventArgs e) => open();
    void Acknowledge_Click(object sender, RoutedEventArgs e) => acknowledge();
}
