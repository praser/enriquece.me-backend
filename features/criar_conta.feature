#language: pt
@conta @criar_conta
Funcionalidade: Cadastrar conta
	Para gerenciar suas finanças
	Os usuários devem cadastrar suas contas de movimentação financeira

	Contexto:
		Dado a existência dos usuários abaixo no sistema:
		| nome       | email                 | senha  |
		| John Doe   | johndoe@exemplo.com   | 123456 |
		| Mike Tyson | miketyson@exemplo.com | 123456 |
		| Rob Stark  | robstark@exemplo.com  | 123456 |
		E a existência das instituições financeiras abaixo no sistema:
		| nome 						| código |
		|Caixa Econômica Federal 	| 104	 |
		|Banco do Brasil 			| 1		 |
		|Itaú						| 341	 |
		E a existência dos tipos de conta abaixo no sistema:
		|nome				|
		|Conta corrente  	|
		|Conta salário		|
	
	Cenário: Um usuário autenticado solicita o cadastramento de uma nova conta com dados válidos
		Dado que o usuário está autenticado no sistema através do email "johndoe@exemplo.com" e da senha "123456"
		Quando o backend receber uma requisição autenticada para o cadastramento de uma conta "Conta corrente" no banco "Itaú" com os parâmetros
		"""
		{
			"name": "Nova conta",
			"description": "Minha nova conta",
			"initial_balance": 30
		}
		"""
		Então a resposta deve possuir status "201"
		E a resposta deve possuir o content/type "application/json; charset=utf-8"
		E o corpo da resposta deve corresponder ao formato JSON API
	
	Cenário: Um usuário autenticado solicita o cadastramento de uma nova conta com dados inválidos
		Dado que o usuário está autenticado no sistema através do email "johndoe@exemplo.com" e da senha "123456"
		Quando o backend receber uma requisição autenticada para "/accounts" através do método "POST" com os parâmetros
		"""
		{
		}
		"""
		Então a resposta deve possuir status "422"
		E a resposta deve possuir o content/type "application/json; charset=utf-8"
		E o corpo da resposta deve corresponder ao formato JSON API
		E o corpo da resposta deve conter uma mensagem informando que o campo "nome" "deve ser informado"
		E o corpo da resposta deve conter uma mensagem informando que o campo "saldo inicial" "deve ser informado" 
		E o corpo da resposta deve conter uma mensagem informando que o campo "banco" "deve ser informado" 
		E o corpo da resposta deve conter uma mensagem informando que o campo "tipo de conta" "deve ser informado"

	Cenário: Um usuário não autenticado solicita o cadastramento de uma nova conta
		Quando o backend receber uma requisição não autenticada para "/accounts" através do método "POST"
		Então a resposta deve possuir status "401"
		E a resposta deve possuir o content/type "application/json; charset=utf-8"
		E o corpo da resposta deve corresponder ao formato JSON API
		E o corpo da resposta deve conter uma mensagem informando que o acesso foi negado