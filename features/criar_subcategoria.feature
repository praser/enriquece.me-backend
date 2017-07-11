#language: pt
@subcategoria @criar_subcategoriacategoria
Funcionalidade: Criar subcategoria
  Para categorizar melhor suas movimentações financeiras
  Os usuários devem poder classificar suas movimentações financeiras em subcategorias

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
  
  Cenário: Um usuário autenticado solicita o cadastramento de uma nova subcategoria com dados válidos
    Dado que o usuário está autenticado no sistema através do email "johndoe@exemplo.com" e da senha "123456"
    Quando o backend receber uma requisição autenticada para o cadastramento de uma subcategoria de "Alimentação" com os parâmetros
    """
    {
      "name": "Supermercado"
    }
    """
    Então a subcategoria "Supermercado" deve ser cadastrada
    E a subcategoria "Supermercado" deve estar relacionada a "Alimentação"
    E a resposta deve possuir status "201"
    E a resposta deve possuir o content type "application/json; charset=utf-8"
    E o corpo da resposta deve corresponder ao formato JSON API
    E a subcategoria "Supermercado" deve estar presente na resposta.
  
  Cenário: Um usuário autenticado solicita o cadastramento de uma nova subcategoria com dados inválidos
    Dado que o usuário está autenticado no sistema através do email "johndoe@exemplo.com" e da senha "123456"
    Quando o backend receber uma requisição autenticada para o cadastramento de uma subcategoria de "Alimentação" com os parâmetros
    """
    {
    }
    """
    Então a resposta deve possuir status "422"
    E a resposta deve possuir o content type "application/json; charset=utf-8"
    E o corpo da resposta deve corresponder ao formato JSON API
    E o corpo da resposta deve conter uma mensagem informando que o campo "nome" "deve ser informado"
  
  Cenário: Um usuário não autenticado solicita o cadastramento de uma nova categoria
    Quando o backend receber uma requisição não autenticada para "/subcategories" através do método "POST"
    Então a resposta deve possuir status "401"
    E a resposta deve possuir o content type "application/json; charset=utf-8"
    E o corpo da resposta deve corresponder ao formato JSON API
    E o corpo da resposta deve conter uma mensagem informando que o acesso foi negado