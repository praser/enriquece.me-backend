#language: pt
@contas @listar_contas
Funcionalidade: Listar todas as contas do usuário
	O backend deve fornecer uma lista com todas as contas do usuário

	Contexto:
		Dado a existência dos usuários abaixo no sistema:
		| nome       | email                 | senha  |
		| John Doe   | johndoe@exemplo.com   | 123456 |
		| Mike Tyson | miketyson@exemplo.com | 123456 |
		| Rob Stark  | robstark@exemplo.com  | 123456 |
		E a existência das instituições financeiras abaixo no sistema:
		| nome 						| código |
		| Caixa Econômica Federal 	| 104	 |
		| Banco do Brasil 			| 1		 |
		| Itaú						| 341	 |
		E a existência dos tipos de conta abaixo no sistema:
		| nome				|
		| Conta corrente 	|
		| Conta poupança	|
		| Conta salário		|
		E a existência das contas abaixo no sistema:
		| nome		| saldo_inicial | banco						| tipo				| usuario				|
		| Conta 1	| 100.0			| Banco do Brasil			| Conta corrente	| johndoe@exemplo.com	|
		| Conta 2	| 50.0			| Caixa Econômica Federal	| Conta poupança 	| johndoe@exemplo.com	|
		| Conta 3	| 30.0			| Itaú						| Conta corrente 	| miketyson@exemplo.com	|
	
	Cenário: Quando um usuário autenticado solicita a lista das suas contas
		Dado que o usuário está autenticado no sistema através do email "johndoe@exemplo.com" e da senha "123456"
		Quando o backend receber uma requisição autenticada para "/accounts" através do método "GET"
		Então a resposta deve possuir status "200"
		E a resposta deve possuir o content/type "application/json; charset=utf-8"
		E o corpo da resposta deve corresponder ao formato JSON API
		E o a lista deve conter "2" "contas"
		
	Cenário: Quando um usuário não autenticado solicita a lista de contas
		Quando o backend receber uma requisição não autenticada para "/accounts" através do método "GET"
		Então a resposta deve possuir status "401"
		E a resposta deve possuir o content/type "application/json; charset=utf-8"
		E o corpo da resposta deve corresponder ao formato JSON API
		E o corpo da resposta deve conter uma mensagem informando que o acesso foi negado