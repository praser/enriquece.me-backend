#language: pt
@categoria @editar_categoria
Funcionalidade: Editar categoria
	Para gerenciar suas finanças
	Os usuários podem editar as categorias que tiver cadastrado

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
	
	Cenário: Um usuário autenticado solicita a edição de uma de suas categorias informado dados válidos
		Dado que o usuário está autenticado no sistema através do email "johndoe@exemplo.com" e da senha "123456"
		Quando o backend receber uma requisição autenticada para alterar a categoria "Alimentação" com os parâmetros
		"""
		{
			"name": "Supermercado"
		}
		"""
		Então a resposta deve possuir status "200"
		E a resposta deve possuir o content type "application/json; charset=utf-8"
		E o corpo da resposta deve corresponder ao formato JSON API
		E o campo "nome" da conta deve ser "Supermercado"

	Cenário: Um usuário autenticado solicita a edição de uma de suas categorias informado dados inválidos
		Dado que o usuário está autenticado no sistema através do email "johndoe@exemplo.com" e da senha "123456"
		Quando o backend receber uma requisição autenticada para alterar a categoria "Alimentação" com os parâmetros
		"""
		{
			"name": null
		}
		"""
		Então a resposta deve possuir status "422"
		E a resposta deve possuir o content type "application/json; charset=utf-8"
		E o corpo da resposta deve corresponder ao formato JSON API
		E o corpo da resposta deve conter uma mensagem informando que o campo "nome" "deve ser informado"
	
	Cenário: Um usuário não autenticado solicita a edição de uma conta
		Quando o backend receber uma requisição não autenticada para alterar a categoria "Saúde"
		Então a resposta deve possuir status "401"
		E a resposta deve possuir o content type "application/json; charset=utf-8"
		E o corpo da resposta deve corresponder ao formato JSON API
		E o corpo da resposta deve conter uma mensagem informando que o acesso foi negado
	
	Cenário: Um usuário autenticado solicita a edição de uma categoria de outro usuário
		Dado que o usuário está autenticado no sistema através do email "johndoe@exemplo.com" e da senha "123456"
		Quando o backend receber uma requisição autenticada para alterar a categoria "Transporte" com os parâmetros
		"""
		{
			"name": "Lazer"
		}
		"""
		Então a resposta deve possuir status "401"
		E a resposta deve possuir o content type "application/json; charset=utf-8"
		E o corpo da resposta deve corresponder ao formato JSON API
		E o corpo da resposta deve conter uma mensagem informando que o acesso foi negado