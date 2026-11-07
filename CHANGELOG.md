# Histórico de versões

## 1.6.0 — 2026-11-06

### Adicionado

- Identidade **CodePing** em todos os idiomas, janela, bandeja, aviso e metadados do aplicativo.
- Logo original em SVG/XAML, PNG transparente e ICO com nove resoluções, integrada ao painel, ao aviso e ao executável.
- Aviso permanece visível enquanto o mouse está sobre ele, mesmo após os três segundos. Sair depois do prazo fecha imediatamente; sair antes não pausa nem reinicia a contagem. Indicação **Em leitura** nos seis idiomas.

### Compatibilidade

- Executável principal `CodePing.exe`; `ClaudeAlerta.exe` passa a ser uma cópia do apphost atual para atalhos e hooks já carregados, sem conservar uma versão antiga.
- Configurações, dados, mutex e marcador do hook preservados. Integração e diagnóstico reconhecem ambos os nomes na mesma instalação, sem duplicar handlers.
- Pacote `CodePing-1.6.0-win-x64.zip`; retenção reconhece releases das duas marcas. Compilação prepara uma saída limpa antes de substituir a publicação anterior.

## 1.5.0 — 2026-11-06

### Adicionado

- Projeto em destaque e conversa em linha própria nas notificações de três segundos.
- Identificação da conversa em Sessões, Pendências, Histórico e na lista de sessões de Projetos.
- Captura opcional do título personalizado fornecido pelo Claude Code em `session_title` nos eventos SessionStart/UserPromptSubmit.
- Ação **Nome da conversa** para definir um apelido local por ID de sessão. Remover o apelido restaura o título recebido ou o ID curto.
- Editor acessível e mensagens nos seis idiomas; atualização do nome em avisos abertos sem reiniciar o prazo.

### Compatibilidade

- Preserva configurações, pendências, perfis, tema Claro e comportamento de abrir o projeto no VS Code.
- Arquivos anteriores sem títulos ou apelidos continuam legíveis. Títulos seguem a retenção da atividade; apelidos locais ficam nas preferências até serem removidos.
- Títulos automáticos não são fornecidos no campo de título personalizado. O programa usa ID como alternativa e não lê transcrições ou prompts para descobrir nomes.

## 1.4.0 — 2026-10-28

### Alterado

- Navegação lateral única para Pendências, Sessões, Histórico, Projetos e Preferências, substituindo as duas fileiras de abas padrão.
- Sessões como tela inicial, reunindo todas as sessões acompanhadas acima dos perfis.
- Normal, Ocupado e Silencioso em cartões com seleção direta, destaque e indicação de perfil em uso.
- Personalização sempre aberta, atualizada imediatamente ao escolher um perfil; Silencioso mantém as opções visíveis e desativadas.
- Retomada e botão Voltei ao lado do perfil escolhido. O atalho Perfil nas demais áreas leva aos cartões em Sessões.
- Preferências globais e diagnóstico em área própria; histórico com acesso direto pelo menu lateral.
- Traduções dos seis idiomas, README, capturas reais e referência visual aprovada atualizados.

### Compatibilidade

- Mantém o tema Claro, o aviso de três segundos e o protocolo de hooks.
- Preferências, pendências, adiamentos, histórico e regras de projeto 1.3.0 são preservados, sem migração do formato de dados.

## 1.3.0 — 2026-10-28

### Adicionado

- Aba Atenção com fila por solicitação, sessões, recentes e contexto do projeto/ferramenta.
- Adiamento individual de 5, 15 ou 30 minutos, preservado após reiniciar.
- Histórico local com retenção de 24 horas e até 500 atividades.
- Perfis Normal, Ocupado e Silencioso, retorno programado e resumo da ausência.
- Lembretes progressivos com intervalos de 2, 5 e 15 minutos e limite de três repetições por solicitação.
- Aba Projetos com apelidos, fixação, silêncio, categorias e intervalos independentes.
- Diagnóstico de configuração/escrita da fila e indicação do último evento recebido.
- Pacote Windows com runtime incluído e arquivo SHA-256.

### Alterado

- “Já vi” substituído por adiamento explícito, preservando solicitações ainda sem resposta.
- Preferências globais recolhidas em um menu discreto.
- Conclusões e erros separados das solicitações pendentes.
- Correlação conservadora de ferramentas paralelas; resultados ambíguos não apagam permissões.
- Estados recuperados identificados como aguardando confirmação por novo evento.
- Os seis idiomas cobrem as novas telas. Tema Claro e avisos de três segundos preservados.

### Compatibilidade

- Preferências 1.2.0 mantêm idioma, som, popup e intervalo escolhido.
- Nenhuma mudança no protocolo de entrada dos hooks ou no caminho dos dados locais.
- Novas instalações usam lembretes progressivos; a atualização não muda automaticamente um intervalo legado.

## 1.2.0 — 2026-10-27

- Seleção persistente de português, inglês, espanhol, alemão, francês e chinês simplificado.
- Tradução imediata do painel, aviso, bandeja e mensagens, preservando pendências.

## 1.1.0 — 2026-10-27

- Tema Claro aprovado e interface WPF.
- Aviso de três segundos com recolhimento automático, sem solicitar foco.
- Monitor local de hooks do Claude Code, bandeja e preferências de avisos.
