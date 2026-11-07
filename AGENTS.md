# Preferências permanentes deste projeto

- Manter somente a release mais recente do CodePing no computador. Não conservar pastas de backup de executáveis nem ZIPs de versões anteriores após uma atualização bem-sucedida.
- Validar a nova publicação antes de substituir a instalação. A instalação desta máquina fica na pasta única `../release/ClaudeAlerta`; preservar suas configurações em `%LOCALAPPDATA%/ClaudeAlerta` e os hooks do usuário.
- O empacotamento remove automaticamente pacotes anteriores em `artifacts/releases` após validar o ZIP atual e seu SHA-256. Para as pastas legadas desta máquina, usar `scripts/clean-releases.ps1 -LegacyRoot <pasta Cameras>` depois de validar a nova instalação.
- Excluir somente distribuições do CodePing identificadas pelo nome da pasta e pelo executável. CasaCameras e outros projetos no diretório pai estão fora do escopo desta limpeza.
- Preservar o histórico de commits, tags e releases no GitHub. A preferência de remoção é local; não apagar versões do GitHub sem pedido explícito.

- Nome atual: CodePing, executável principal CodePing.exe. ClaudeAlerta.exe é apphost de compatibilidade da mesma versão; manter os dois idênticos. Preservar mutex, marcador de hook, pasta de dados e caminho de instalação históricos. Nunca manter DLLs/runtimeconfigs antigos na publicação.
- Repositório oficial: https://github.com/victorcqueiroz/CodePing. Usar este endereço nos remotes, links de documentação, downloads e futuras publicações.
