using System.Windows;

namespace ClaudeAlerta;

public partial class ConversationEditor : Window
{
    readonly Action<string> save;
    internal ConversationEditor(SessionState session, Preferences prefs, Action<string> save)
    {
        this.save = save; InitializeComponent(); UiTheme.ApplyAccessibility(Resources);
        Language = System.Windows.Markup.XmlLanguage.GetLanguage(L.Current);
        EditorProject.Text = prefs.ProjectName(session);
        OriginalTitle.Text = string.IsNullOrWhiteSpace(session.Title) ? L.T("ConversationTitleUnavailable") : L.F("ClaudeConversationTitle", session.Title);
        SessionIdentifier.Text = L.F("SessionIdentifier", session.Id);
        ConversationAliasInput.Text = prefs.ConversationAliases.GetValueOrDefault(session.Id) ?? "";
        Loaded += (_, _) => { ConversationAliasInput.Focus(); ConversationAliasInput.SelectAll(); };
    }
    void Save_Click(object sender, RoutedEventArgs e) { save(ConversationNames.Clean(ConversationAliasInput.Text)); Close(); }
    void Cancel_Click(object sender, RoutedEventArgs e) => Close();
}
