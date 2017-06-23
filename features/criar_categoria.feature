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
		E a resposta deve possuir o content type "application/json; charset=utf-8"
		E o corpo da resposta deve corresponder ao formato JSON API
		E a categoria "Alimentação" deve estar presente na resposta.
	
	Cenário: Um usuário autenticado solicita o cadastramento de uma nova categoria com dados inválidos
		Dado que o usuário está autenticado no sistema através do email "johndoe@exemplo.com" e da senha "123456"
		Quando o backend receber uma requisição autenticada para "/categories" através do método "POST" com os parâmetros
		"""
		{
		}
		"""
		Então a resposta deve possuir status "422"
		E a resposta deve possuir o content type "application/json; charset=utf-8"
		E o corpo da resposta deve corresponder ao formato JSON API
		E o corpo da resposta deve conter uma mensagem informando que o campo "nome" "deve ser informado"

	Cenário: Um usuário não autenticado solicita o cadastramento de uma nova categoria
		Quando o backend receber uma requisição não autenticada para "/categories" através do método "POST"
		Então a resposta deve possuir status "401"
		E a resposta deve possuir o content type "application/json; charset=utf-8"
		E o corpo da resposta deve corresponder ao formato JSON API
		E o corpo da resposta deve conter uma mensagem informando que o acesso foi negado