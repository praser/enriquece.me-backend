#language: pt
@subcategoria @editar_subcategoria
Funcionalidade: Editar subcategoria
	Para categorizar melhor suas movimentações financeiras
	Os usuários devem poder editar suas subcategorias

	Contexto:
		Dado a existência dos usuários abaixo no sistema:
		| nome       | email                 | senha  |
		| John Doe   | johndoe@exemplo.com   | 123456 |
		| Mike Tyson | miketyson@exemplo.com | 123456 |
		| Rob Stark  | robstark@exemplo.com  | 123456 |
		E a existência das categorias abaixo no sistma:
		| nome			| usuario				|
		| Alimentação	| johndoe@exemplo.com	|
		| Saúde			| johndoe@exemplo.com	|
		| Transporte	| robstark@exemplo.com	|
		E a existência das subcategorias abaixo no sistema:
		| nome			| categoria		|
		| Supermercado	| Alimentação	|
		| Restaurante	| Alimentação	|
		| Remédios		| Saúde			|
		| Combustível	| Transporte	|
	
	Cenário: Um usuário autenticado solicita a edição de uma de suas subcategorias informado dados válidos
		Dado que o usuário está autenticado no sistema através do email "johndoe@exemplo.com" e da senha "123456"
		Quando o backend receber uma requisição autenticada para alterar a subcategoria "Restaurante" com os parâmetros
		"""
		{
			"name": "Refeições fora de casa"
		}
		"""
		Então a resposta deve possuir status "200"
		E a resposta deve possuir o content type "application/json; charset=utf-8"
		E o corpo da resposta deve corresponder ao formato JSON API
		E o campo "nome" da subcategoria deve ser "Refeições fora de casa"
	
	Cenário: Um usuário autenticado solicita a edição de uma de suas subcategorias informado dados inválidos
		Dado que o usuário está autenticado no sistema através do email "johndoe@exemplo.com" e da senha "123456"
		Quando o backend receber uma requisição autenticada para alterar a subcategoria "Supermercado" com os parâmetros
		"""
		{
			"name": null
		}
		"""
		Então a resposta deve possuir status "422"
		E a resposta deve possuir o content type "application/json; charset=utf-8"
		E o corpo da resposta deve corresponder ao formato JSON API
		E o corpo da resposta deve conter uma mensagem informando que o campo "nome" "deve ser informado"
	
	Cenário: Um usuário não autenticado solicita a edição de uma subcategoria
		Quando o backend receber uma requisição não autenticada para alterar a subcategoria "Remédios"
		Então a resposta deve possuir status "401"
		E a resposta deve possuir o content type "application/json; charset=utf-8"
		E o corpo da resposta deve corresponder ao formato JSON API
		E o corpo da resposta deve conter uma mensagem informando que o acesso foi negado
	
	Cenário: Um usuário autenticado solicita a edição de uma subcategoria de outro usuário
		Dado que o usuário está autenticado no sistema através do email "johndoe@exemplo.com" e da senha "123456"
		Quando o backend receber uma requisição autenticada para alterar a subcategoria "Combustível" com os parâmetros
		"""
		{
			"name": "Gasolina"
		}
		"""
		Então a resposta deve possuir status "401"
		E a resposta deve possuir o content type "application/json; charset=utf-8"
		E o corpo da resposta deve corresponder ao formato JSON API
		E o corpo da resposta deve conter uma mensagem informando que o acesso foi negado