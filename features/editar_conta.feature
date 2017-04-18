#language: pt
@conta @editar_conta
Funcionalidade: Editar conta
	Para gerenciar suas finanças
	Os usuários podem editar suas contas de movimentação financeira

	Contexto:
		Dado a existência dos usuários abaixo no sistema:
		| nome       | email                 | senha  |
		| John Doe   | johndoe@exemplo.com   | 123456 |
		| Mike Tyson | miketyson@exemplo.com | 123456 |
		| Rob Stark  | robstark@exemplo.com  | 123456 |
		E a existência das instituições financeiras abaixo no sistema:
		| nome 					| código |
		| Caixa Econômica Federal 	| 104	 |
		| Banco do Brasil 			| 1		 |
		| Itaú						| 341	 |
		E a existência dos tipos de conta abaixo no sistema:
		| nome				|
		| Conta corrente 	|
		| Conta poupança	|
		| Conta salário	|
		E a existência das contas abaixo no sistema:
		| nome		| saldo_inicial | banco						| tipo				| usuario				|
		| Conta 1	| 100.0			| Banco do Brasil			| Conta corrente	| johndoe@exemplo.com	|
		| Conta 2	| 50.0			| Caixa Econômica Federal	| Conta poupança 	| johndoe@exemplo.com	|
		| Conta 3	| 30.0			| Itaú						| Conta corrente 	| miketyson@exemplo.com	|
	
	Cenário: Um usuário autenticado solicita a edição de uma de suas contas informado dados válidos
		Dado que o usuário está autenticado no sistema através do email "johndoe@exemplo.com" e da senha "123456"
		Quando o backend receber uma requisição autenticada para alterar a conta "Conta 1" com os parâmetros
		"""
		{
			"name": "Conta 1 alterada",
			"description": "Minha conta principal",
			"initial_balance": 300.0
		}
		"""
		Então a resposta deve possuir status "200"
		E a resposta deve possuir o content/type "application/json; charset=utf-8"
		E o corpo da resposta deve corresponder ao formato JSON API
		E o campo "nome" da conta deve ser "Conta 1 alterada"
		E o campo "descricao" da conta deve ser "Minha conta principal"
		E o campo "saldo inicial" da conta deve ser "300.0"
	
	Cenário: Um usuário autenticado solicita a edição de uma de suas contas informado dados inválidos
		Dado que o usuário está autenticado no sistema através do email "johndoe@exemplo.com" e da senha "123456"
		Quando o backend receber uma requisição autenticada para alterar a conta "Conta 1" com os parâmetros
		"""
		{
			"name": null,
			"initial_balance": null
		}
		"""
		Então a resposta deve possuir status "422"
		E a resposta deve possuir o content/type "application/json; charset=utf-8"
		E o corpo da resposta deve corresponder ao formato JSON API
		E o corpo da resposta deve conter uma mensagem informando que o campo "nome" "deve ser informado"
		E o corpo da resposta deve conter uma mensagem informando que o campo "saldo inicial" "deve ser informado" 
	
	
	Cenário: Um usuário não autenticado solicita a edição de uma conta
		Quando o backend receber uma requisição não autenticada para alterar a conta "Conta 1"
		Então a resposta deve possuir status "401"
		E a resposta deve possuir o content/type "application/json; charset=utf-8"
		E o corpo da resposta deve corresponder ao formato JSON API
		E o corpo da resposta deve conter uma mensagem informando que o acesso foi negado
	
	Cenário: Um usuário autenticado solicita a edição de uma conta de outro usuário
		Dado que o usuário está autenticado no sistema através do email "johndoe@exemplo.com" e da senha "123456"
		Quando o backend receber uma requisição autenticada para alterar a conta "Conta 3" com os parâmetros
		"""
		{
			"name": "Conta 1 alterada",
			"description": "Minha conta principal",
			"initial_balance": 300.0
		}
		"""
		Então a resposta deve possuir status "401"
		E a resposta deve possuir o content/type "application/json; charset=utf-8"
		E o corpo da resposta deve corresponder ao formato JSON API
		E o corpo da resposta deve conter uma mensagem informando que o acesso foi negado