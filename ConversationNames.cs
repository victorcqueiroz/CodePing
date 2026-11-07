using System.Globalization;
using System.Text;

namespace ClaudeAlerta;

internal static class ConversationNames
{
    internal static string Clean(string? value)
    {
        var result = new StringBuilder(); bool space = false; int length = 0;
        foreach (var rune in (value ?? "").EnumerateRunes())
        {
            if (Rune.IsWhiteSpace(rune)) { space = result.Length > 0; continue; }
            if (Rune.IsControl(rune) || Rune.GetUnicodeCategory(rune) == UnicodeCategory.Format) continue;
            if (space) { if (length >= 160) break; result.Append(' '); length++; space = false; }
            if (length >= 160) break;
            result.Append(rune.ToString()); length++;
        }
        return result.ToString().TrimEnd();
    }
}
