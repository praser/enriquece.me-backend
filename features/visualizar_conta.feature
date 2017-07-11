#language: pt
@conta @visualizar_conta
Funcionalidade: Visualizar conta
  Os usuários devem visualizar os dados das suas contas de movimentação financeira

  Contexto:
    Dado a existência dos usuários abaixo no sistema:
  | nome       | email                 | senha  |
  | John Doe   | johndoe@exemplo.com   | 123456 |
  | Mike Tyson | miketyson@exemplo.com | 123456 |
  | Rob Stark  | robstark@exemplo.com  | 123456 |
    E a existência das instituições financeiras abaixo no sistema:
  | nome                    | código |
  | Caixa Econômica Federal | 104    |
  | Banco do Brasil         | 1      |
  | Itaú                    | 341    |
    E a existência dos tipos de conta abaixo no sistema:
  | nome           |
  | Conta corrente |
  | Conta poupança |
  | Conta salário  |
    E a existência das contas abaixo no sistema:
  | nome    | saldo_inicial | banco                   | tipo           | usuario               |
  | Conta 1 | 100.0         | Banco do Brasil         | Conta corrente | johndoe@exemplo.com   |
  | Conta 2 | 50.0          | Caixa Econômica Federal | Conta poupança | johndoe@exemplo.com   |
  | Conta 3 | 30.0          | Itaú                    | Conta corrente | miketyson@exemplo.com |

  
  Cenário: Quando um usuário autenticado solicita acesso aos dados de uma de suas contas
    Dado que o usuário está autenticado no sistema através do email "johndoe@exemplo.com" e da senha "123456"
    Quando o backend receber uma requisição autenticada para exibir dados da conta "Conta 1"
    Então a resposta deve possuir status "200"
    E a resposta deve possuir o content type "application/json; charset=utf-8"
    E o corpo da resposta deve corresponder ao formato JSON API
    E o campo "nome" da conta deve ser "Conta 1"
    E o campo "saldo inicial" da conta deve ser "100.0"
  
  Cenário: Quando um usuário não autenticado solicita acesso aos dados de uma conta
    Quando o backend receber uma requisição não autenticada para exibir dados da conta "Conta 1"
    Então a resposta deve possuir status "401"
    E a resposta deve possuir o content type "application/json; charset=utf-8"
    E o corpo da resposta deve corresponder ao formato JSON API
    E o corpo da resposta deve conter uma mensagem informando que o acesso foi negado
  
  Cenário: Quando um usuário autenticado soliciata acesso aos dados de uma conta de outro usuário
    Dado que o usuário está autenticado no sistema através do email "johndoe@exemplo.com" e da senha "123456"
    Quando o backend receber uma requisição autenticada para exibir dados da conta "Conta 3"
    Então a resposta deve possuir status "401"
    E a resposta deve possuir o content type "application/json; charset=utf-8"
    E o corpo da resposta deve corresponder ao formato JSON API
    E o corpo da resposta deve conter uma mensagem informando que o acesso foi negado