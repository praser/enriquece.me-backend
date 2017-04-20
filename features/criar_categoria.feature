#language: pt
@categoria @criar_categoria
Funcionalidade: Criar categoria
	Para gerenciar suas finanças
	Os usuários devem classificar suas movimentações financeiras em categorias

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
		| Conta corrente  	|
		| Conta salário		|
		| Conta poupança	|
		E a existência das contas abaixo no sistema:
		| nome		| saldo_inicial | banco						| tipo				| usuario				|
		| Conta 1	| 100.0			| Banco do Brasil			| Conta corrente	| johndoe@exemplo.com	|
		| Conta 2	| 50.0			| Caixa Econômica Federal	| Conta poupança 	| johndoe@exemplo.com	|
		| Conta 3	| 30.0			| Itaú						| Conta corrente 	| miketyson@exemplo.com	|
	
	Cenário: Um usuário autenticado solicita o cadastramento de uma nova categoria com dados válidos
		Dado que o usuário está autenticado no sistema através do email "johndoe@exemplo.com" e da senha "123456"
		Quando o backend receber uma requisição autenticada para "/categories" através do método "POST" com os parâmetros
		"""
		{
			"name": "Alimentação"
		}
		"""
		Então a categoria "Alimentação" deve ser cadastrada
		E a resposta deve possuir status "201"
		E a resposta deve possuir o content/type "application/json; charset=utf-8"
		E o corpo da resposta deve corresponder ao formato JSON API
		E a categoria "Alimentação" deve estar presente na resposta.
	
	Cenário: Um usuário autenticado solicita o cadastramento de uma nova categoria com dados inválidos
		Dado que o usuário está autenticado no sistema através do email "johndoe@exemplo.com" e da senha "123456"
		Quando o backend receber uma requisição autenticada para "/categories" através do método "POST" com os parâmetros
		"""
		{
		}
		"""
		E a resposta deve possuir status "422"
		E a resposta deve possuir o content/type "application/json; charset=utf-8"
		E o corpo da resposta deve corresponder ao formato JSON API
		E o corpo da resposta deve conter uma mensagem informando que o campo "nome" "deve ser informado"

	Cenário: Um usuário não autenticado solicita o cadastramento de uma nova categoria
		Quando o backend receber uma requisição não autenticada para "/categories" através do método "POST"
		Então a resposta deve possuir status "401"
		E a resposta deve possuir o content/type "application/json; charset=utf-8"
		E o corpo da resposta deve corresponder ao formato JSON API
		E o corpo da resposta deve conter uma mensagem informando que o acesso foi negado