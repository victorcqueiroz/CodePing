# CodePing: nome e identidade

O usuário escolheu explicitamente CodePing e pediu uma logo. Aplicar a marca em todos os idiomas, janela, bandeja, aviso, metadados do executável, pacote e README. Versão 1.6.0, mantendo o repositório GitHub atual.

Logo vetorial original: colchetes de código brancos sobre quadrado azul arredondado, com ponto de notificação verde. Usar o mesmo desenho em WPF, SVG, PNG e ICO multirresolução. Não alterar o tema Claro ou o comportamento de monitoramento.

Compatibilidade: preservar namespace, mutex, marcador do hook e pasta de dados existentes. Executável principal CodePing.exe; ClaudeAlerta.exe será uma cópia do apphost atual para hooks/atalhos já carregados. Os dois nomes devem apontar somente para a nova versão. Aceitar ambos os nomes na identificação de hooks e removê-los sem duplicação. Manter a pasta de instalação existente e atualizar a integração com backup, preservando hooks de terceiros.

Compilação deve preparar saída nova isolada antes de substituir artifacts/publish/win-x64, para não empacotar DLLs da marca antiga. Retenção reconhece pacotes CodePing e antigos ClaudeAlert. Validar antes de instalar/publicar, preservar somente release atual local e histórico remoto.

## Mouse sobre o aviso

O relógio de três segundos continua normalmente. Se o ponteiro estiver sobre a superfície do aviso ao vencer o prazo, segurar a janela e indicar leitura. Ao sair depois do prazo, fechar imediatamente. Se sair antes, usar o tempo restante; nunca reiniciar ou pausar o relógio. Preservar ausência de foco e fechamento por confirmação da solicitação.
