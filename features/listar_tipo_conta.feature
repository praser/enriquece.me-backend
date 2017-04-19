#language: pt
@tipo_conta @listar_tipo_conta
Funcionalidade: Listar todas as instituições financeiras
	O backend deve fornecer uma lista com todas as instituições financeiras cadastradas

	Contexto:
		Dado a existência dos usuários abaixo no sistema:
		| nome       | email                 | senha  |
		| John Doe   | johndoe@exemplo.com   | 123456 |
		| Mike Tyson | miketyson@exemplo.com | 123456 |
		| Rob Stark  | robstark@exemplo.com  | 123456 |
		E a existência dos tipos de conta abaixo no sistema:
		| nome				|
		| Conta corrente 	|
		| Conta poupança	|
		| Conta salário		|	
	
	Cenário: Quando um usuário autenticado solicita a lista dos tipos de contas
		Dado que o usuário está autenticado no sistema através do email "johndoe@exemplo.com" e da senha "123456"
		Quando o backend receber uma requisição autenticada para "/account_types" através do método "GET"
		Então a resposta deve possuir status "200"
		E a resposta deve possuir o content/type "application/json; charset=utf-8"
		E o corpo da resposta deve corresponder ao formato JSON API
		
	Cenário: Quando um usuário não autenticado solicita a lista de instituições financeiras
		Quando o backend receber uma requisição não autenticada para "/banks" através do método "GET"
		Então a resposta deve possuir status "401"
		E a resposta deve possuir o content/type "application/json; charset=utf-8"
		E o corpo da resposta deve corresponder ao formato JSON API
		E o corpo da resposta deve conter uma mensagem informando que o acesso foi negado