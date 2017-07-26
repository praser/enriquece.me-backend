#language: pt

@movimentacao_financeira @criar_movimentacao_financeira
Funcionalidade: Criar movimentações simples
  Para registras suas movimentações financeiras
  Como um usuário
  Eu gostaria de cadastrar minhas despesas

  Contexto:
    Dado a existência dos usuários abaixo no sistema:
    | nome      | email                | senha  |
    | John Doe  | johndoe@exemplo.com  | 123456 |
    | Rob Stark | robstark@exemplo.com | 123456 |
    E a existência das instituições financeiras abaixo no sistema:
    | nome                    | código |
    | Caixa Econômica Federal | 104    |
    | Banco do Brasil         | 1      |
    | Itaú                    | 341    |
    E a existência dos tipos de conta abaixo no sistema:
    | nome           |
    | Conta corrente |
    | Conta salário  |
    E a existência das contas abaixo no sistema:
    | nome                      | descricao                     | saldo_inicial | tipo           | banco | usuario              |
    | Conta corrente principal  | Principal conta de John Doe   | 0             | Conta corrente | Itaú  | johndoe@exemplo.com  |
    | Conta corrente secundária | Conta secundária de John Doe  | 0             | Conta corrente | Itaú  | johndoe@exemplo.com  |
    | Conta corrente legal      | Principal conta de Rob Stark  | 0             | Conta corrente | Itaú  | robstark@exemplo.com |
    | Conta corrente maneira    | Conta secundária de Rob Stark | 0             | Conta corrente | Itaú  | robstark@exemplo.com |
    E a existência das categorias abaixo no sistma:
    | nome        | usuario              |
    | Alimentação | johndoe@exemplo.com  |
    | Saúde       | johndoe@exemplo.com  |
    | Outros      | johndoe@exemplo.com  |
    | Transporte  | robstark@exemplo.com |
    E a existência das subcategorias abaixo no sistema:
    | nome         | categoria   |
    | Supermercado | Alimentação |
    | Remédios     | Saúde       |
    | Combustível  | Transporte  |
  
  Cenário: Quando um usuário autenticado solicita o cadastramento de uma movimentação financeira com dados válidos
    Dado que o usuário se autenticou com a credencial:
    """
    {
      "email": "johndoe@exemplo.com",
      "password": "123456"
    }
    """
    Quando o backend receber uma requisição autenticada para o cadastramento de um movimentação financeira de "Alimentação" na "Conta corrente principal" com os parâmetros
    """
    {
      "description": "Compras no supermercado",
      "price": -50.00,
      "date": "2017-07-01",
      "note": "Abastecendo a dispensa.",
      "recurrence": null
    }
    """
    Então a resposta deve possuir status "201"
    E a resposta deve possuir o content type "application/json; charset=utf-8"
    E o corpo da resposta deve corresponder ao formato JSON API

  Cenário: Quando um usuário autenticado solicita o cadastamento de uma movimentação financeira com dados inválidos
    Dado que o usuário se autenticou com a credencial:
    """
    {
      "email": "johndoe@exemplo.com",
      "password": "123456"
    }
    """
    Quando o backend receber uma requisição autenticada para o cadastramento de um movimentação financeira com parâmetros inválidos
    Entao a resposta deve possuir status "422"
    E a resposta deve possuir o content type "application/json; charset=utf-8"
    E o corpo da resposta deve corresponder ao formato JSON API
    E o corpo da resposta deve conter uma mensagem informando que o campo "descrição" "deve ser informado"
    E o corpo da resposta deve conter uma mensagem informando que o campo "preço" "deve ser informado"
    E o corpo da resposta deve conter uma mensagem informando que o campo "data" "deve ser informado"
    E o corpo da resposta deve conter uma mensagem informando que o campo "conta" "deve ser informado"
    E o corpo da resposta deve conter uma mensagem informando que o campo "categoria" "deve ser informado"

  Cenário: "Quando um usuário autenticado solicita o cadastramento de uma movimentação financeira parcelada com dados válidos"
    Dado que o usuário se autenticou com a credencial:
    """
    {
      "email": "johndoe@exemplo.com",
      "password": "123456"
    }
    """
    Quando o backend receber uma requisição autenticada para o cadastramento de um movimentação financeira de "Outros" na "Conta corrente principal" com os parâmetros
    """
    {
      "description": "Computador",
      "price": -250.00,
      "date": "2017-07-01",
      "recurrence": {
        "every": "month",
        "on": 1,
        "interval": "monthly",
        "repeat": 10
      }
    }
    """
    Então a resposta deve possuir status "201"
    E a resposta deve possuir o content type "application/json; charset=utf-8"
    E o corpo da resposta deve corresponder ao formato JSON API

  Cenário: "Quando um usuário não autenticado solicita o cadastramento de uma movimentação financeira"
    Quando o backend receber uma requisição não autenticada para "/transactions" através do método "POST"
    Então a resposta deve possuir status "401"
    E a resposta deve possuir o content type "application/json; charset=utf-8"
    E o corpo da resposta deve corresponder ao formato JSON API