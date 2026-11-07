# Projeto e conversa nos avisos

Implementar a recomendação aprovada com “prossiga”: destacar o projeto e identificar a conversa no aviso de três segundos, em Sessões, Pendências, Histórico e Projetos. Preservar o tema Claro, os seis idiomas, perfis, foco e adiamento.

## Abordagens

- Somente ID: compatível, mas difícil reconhecer a conversa.
- Ler transcrições para descobrir títulos gerados: depende de formato interno e exige acesso desnecessário ao conteúdo.
- **Escolhida:** título personalizado recebido em `session_title` nos hooks SessionStart/UserPromptSubmit; apelido local opcional por ID; fallback para ID curto. Não ler transcrições nem gerar títulos a partir de prompts.

## Comportamento

O aviso mostra projeto em destaque, conversa identificada e estado do evento. Títulos são metadados opcionais: ausentes não apagam o último recebido; string vazia explícita o limpa. Atualizações atrasadas não substituem dados novos. Sanitizar títulos/apelidos para uma linha, até 160 caracteres Unicode. Nunca usar títulos como identidade: correlação continua por session_id.

Adicionar ação visível “Nome da conversa” nas linhas de Sessões e no detalhe de Pendências/Histórico. Editor modal acessível permite salvar ou remover apelido sem alterar o nome no Claude Code. Apelido local prevalece sobre título, que prevalece sobre ID; alterações se aplicam ao painel e ao aviso aberto sem reiniciar seu prazo.

Persistir títulos no snapshot e nas atividades para sessões encerradas; manter compatibilidade com arquivos anteriores. Apelidos ficam nas preferências até serem removidos. Títulos/atividades seguem retenção de 24 horas. O botão de abrir continua levando ao projeto no VS Code; não prometer seleção da conversa.

Publicar 1.5.0 (funcionalidade compatível), atualizar README/changelog/capturas, validar e instalar na pasta única existente. Preservar configurações e somente a release local mais recente; manter releases antigas no GitHub.

Fonte: https://code.claude.com/docs/en/hooks#sessionstart-input e #userpromptsubmit-input. Títulos gerados automaticamente não são fornecidos em session_title; a disponibilidade depende do Claude Code instalado.
