# Conversation alerts Implementation Plan

> **For agentic workers:** Implementar inline com superpowers:executing-plans. Execução e publicação já autorizadas pelo usuário.

**Goal:** Reconhecer projeto e conversa nos avisos e no painel.
**Architecture:** Metadado opcional no Signal, título persistido no MonitorState/Activity, apelido em Preferences e resolução única dos nomes. Editor WPF e popup com hierarquia projeto/conversa/estado.
**Tech Stack:** C#/.NET 10, WPF, PowerShell 7, JSON embarcado em seis idiomas.
**Spec:** ../specs/2026-11-06-conversation-alerts-design.md

## Global Constraints

- Claro; seis idiomas; popup três segundos sem foco.
- Não ler prompts, mensagens ou transcrições; identidade permanece session_id.
- Snapshot/preferências antigos continuam legíveis.
- Publicar 1.5.0 e manter só release local mais recente.

## Review Focus

- Sessões diferentes na mesma pasta ou com título igual não se misturam.
- Hooks sem título e eventos atrasados preservam o título conhecido.
- Caracteres de controle, nomes longos e chinês não quebram o layout.
- Remover apelido restaura título/ID, sem alterar outras sessões.
- Histórico mantém identidade após SessionEnd/reinício; popup preserva prazo ao atualizar.

### Task 1: Metadados e identificação

Files: Core.cs, MonitorModel.cs, Preferences.cs, ConversationNames.cs, SelfTest.cs.

- [ ] Adicionar teste de protocolo que exige retenção de session_title sem outros conteúdos; observar falha na versão atual.
- [ ] Adicionar Signal.Title opcional; capturar apenas o campo documentado e sanitizar nomes.
- [ ] Testar título por sessão, atualização, ausência, vazio explícito, evento atrasado, histórico/restauração e snapshot legado.
- [ ] Implementar título no estado/atividade e ConversationAliases/ConversationName nas preferências.
- [ ] Verificar núcleo e compatibilidade.

### Task 2: Interface e publicação

Files: AlertCard.xaml/.cs, Dashboard.xaml/.cs, ConversationEditor.xaml/.cs, Locales/*.json, UiCheck.cs, README.md, CHANGELOG.md, VALIDACAO.md, ClaudeAlerta.csproj.

- [ ] Testar título chegando no aviso real, hierarquia, fallback, edição local, cancelamento e persistência.
- [ ] Implementar popup, ação Nome da conversa e editor acessível, todas as áreas com mesma resolução de nomes.
- [ ] Executar suíte completa; revisar capturas em português/seis idiomas e janela mínima.
- [ ] Atualizar documentação e versão; revisar diff.
- [ ] Commit, rebuild com SHA do commit, testes finais, empacotar, publicar tag/release e verificar assets/digests.
- [ ] Instalar executável validado na pasta única, verificar versão/hashes/processo e limpar versões antigas.
