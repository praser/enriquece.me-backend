#language: pt
@subcategoria @remover_subcategoria
Funcionalidade: Remover subcategoria
  Para melhor gerenciar suas finanças
  Os usuários podem remover suas subcategorias

  Contexto:
    Dado a existência dos usuários abaixo no sistema:
  | nome       | email                 | senha  |
  | John Doe   | johndoe@exemplo.com   | 123456 |
  | Mike Tyson | miketyson@exemplo.com | 123456 |
  | Rob Stark  | robstark@exemplo.com  | 123456 |
    E a existência das categorias abaixo no sistma:
  | nome        | usuario              |
  | Alimentação | johndoe@exemplo.com  |
  | Saúde       | johndoe@exemplo.com  |
  | Transporte  | robstark@exemplo.com |
    E a existência das subcategorias abaixo no sistema:
  | nome         | categoria   |
  | Supermercado | Alimentação |
  | Restaurante  | Alimentação |
  | Remédios     | Saúde       |
  | Combustível  | Transporte  |
  
  Cenário: Um usuário autenticado tenta remover uma de suas subcategorias
    Dado que o usuário está autenticado no sistema através do email "johndoe@exemplo.com" e da senha "123456"
    Quando o backend receber uma requisição autenticada para remover a subcategoria "Restaurante"
    Então a resposta deve possuir status "204"
    E a subcategoria "Restaurante" deverá ter sido removida
  
  Cenário: Um usuário não autenticado tenta remover uma subcategoria
    Quando o backend receber uma requisição não autenticada para remover a subcategoria "Restaurante"
    Então a resposta deve possuir status "401"
    E o corpo da resposta deve corresponder ao formato JSON API
    E o corpo da resposta deve conter uma mensagem informando que o acesso foi negado
  
  Cenário: Um usuário autenticado tenta remover uma subcategoria que não é sua
    Dado que o usuário está autenticado no sistema através do email "johndoe@exemplo.com" e da senha "123456"
    Quando o backend receber uma requisição autenticada para remover a subcategoria "Combustível"
    Então a resposta deve possuir status "401"
    E o corpo da resposta deve corresponder ao formato JSON API
    E o corpo da resposta deve conter uma mensagem informando que o acesso foi negado