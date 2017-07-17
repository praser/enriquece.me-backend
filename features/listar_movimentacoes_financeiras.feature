# language: pt

@movimentacao_financeita @listar_movimentacao_financeira

Funcionalidade: Listar movimentações financeiras
  Para gerenciar minhas finanças
  Como um usuário comum
  Eu quero poder listar minhas transações financeiras

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
    E a existência das movimentações financeiras abaixo no sistema:
    | descricao | preco | data       | paga | conta                    | categoria   | subcategoria | usuario              |
    | Mercado   | 33.40 | 2017-06-03 | true | Conta corrente principal | Alimentação | Supermercado | johndoe@exemplo.com  |
    | Mercado 2 | 60.00 | 2017-06-04 | true | Conta corrente principal | Alimentação | Supermercado | johndoe@exemplo.com  |
    | Feira     | 21.90 | 2017-07-01 | true | Conta corrente principal | Alimentação | Supermercado | johndoe@exemplo.com  |
    | Padaria   | 33.46 | 2017-07-02 | true | Conta corrente principal | Alimentação | Supermercado | johndoe@exemplo.com  |
    | Farmácia  | 98.77 | 2017-07-03 | true | Conta corrente principal | Saúde       | Remédios     | johndoe@exemplo.com  |
    | Remédios  | 10.70 | 2017-08-10 | true | Conta corrente principal | Saúde       | Remédios     | johndoe@exemplo.com  |
    | Gasolina  | 50.00 | 2017-07-01 | true | Conta corrente legal     | Transporte  | Combustível  | robstark@exemplo.com |

  Cenário: Um usuário autenticado solicita a listagem de suas transações financeiras
    Dado que o usuário está autenticado no sistema através do email "johndoe@exemplo.com" e da senha "123456"
    Quando o backend receber uma requisição autenticada para listar suas movimentações financeiras
    Então a resposta deve possuir status "200"
    E a resposta deve possuir o content type "application/json; charset=utf-8"
    E o corpo da resposta deve corresponder ao formato JSON API
    E a resposta deve exibir todas as minhas movimentações financeiras do mês

  Cenário: Um usuário não autenticado solicita a listagem de transações financeiras
    Quando o backend receber uma requisição não autenticada para listar movimentações financeiras
    Então a resposta deve possuir status "401"
    E a resposta deve possuir o content type "application/json; charset=utf-8"
    E o corpo da resposta deve corresponder ao formato JSON API
    E o corpo da resposta deve conter uma mensagem informando que o acesso foi negado
  
  Cenário: Um usuário autenticado solicita a listagem de suas transações financeiras começando em uma data específica
    Dado que o usuário está autenticado no sistema através do email "johndoe@exemplo.com" e da senha "123456"
    Quando o backend receber uma requisição autenticada para listar suas movimentações financeiras a partir de "2017-06-04"
    Então a resposta deve possuir status "200"
    E a resposta deve possuir o content type "application/json; charset=utf-8"
    E o corpo da resposta deve corresponder ao formato JSON API
    E a resposta deve exibir todas as minhas movimentações financeiras desde o dia "2017-06-04" até o fim do mês corrente

  Cenário: Um usuário não autenticado solicita a listagem de transações financeiras
    Quando o backend receber uma requisição não autenticada para listar movimentações financeiras a partir de de "2017-06-04"
    Então a resposta deve possuir status "401"
    E a resposta deve possuir o content type "application/json; charset=utf-8"
    E o corpo da resposta deve corresponder ao formato JSON API
    E o corpo da resposta deve conter uma mensagem informando que o acesso foi negado