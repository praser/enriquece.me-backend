#language: pt
@usuario @editar_usuario
Funcionalidade: Editar dados do usuário
	Para gerenciar sua conta na aplicação
	Os usuários devem poder editar os dados das suas contas

	Contexto:
		Dado a existência dos usuários abaixo no sistema:
		| id | nome       | email                 | senha  |
		| 1  | John Doe   | johndoe@exemplo.com   | 123456 |
		| 2  | Mike Tyson | miketyson@exemplo.com | 123456 |
		| 3  | Rob Stark  | robstark@exemplo.com  | 123456 |
	
	Cenário: Quando o usuário altera os seus próprios dados informando dados válidos
		Dado que o usuário está autenticado no sistema através do email "johndoe@exemplo.com" e da senha "123456"
		Quando o backend receber uma requisição autenticada para "/user" através do método "PUT" com os parâmetros
		"""
		{
			"name": "John Doe Exemplo",
			"password": "654321"
		}
		"""
		Então a resposta deve possuir status "200"
		E a resposta deve possuir o content/type "application/json; charset=utf-8"
		E o corpo da resposta deve corresponder ao formato JSON API
		E o "nome" do usuário deve ser "John Doe Exemplo"
		E o "email" do usuário deve ser "johndoe@exemplo.com"

	Cenário: Quando o usuário altera os seus próprios dados informando dados inválidos
		Dado que o usuário está autenticado no sistema através do email "johndoe@exemplo.com" e da senha "123456"
		Quando o backend receber uma requisição autenticada para "/user" através do método "PUT" com os parâmetros
		"""
		{
			"name": "",
			"senha": ""
		}
		"""
		Então a resposta deve possuir status "422"
		E a resposta deve possuir o content/type "application/json; charset=utf-8"
		E o corpo da resposta deve corresponder ao formato JSON API

	Cenário: Quando um usuário tenta alterar aos seus próprios dados sem estar autenticado
		Quando o backend receber uma requisição autenticada para "/user" através do método "PUT" com os parâmetros
		"""
		{
			"name": "John Doe Exemplo",
			"email": "novoemaildojohndoe@exemplo.com",
			"password": "654321"
		}
		"""
		Então a resposta deve possuir status "401"
		E a resposta deve possuir o content/type "application/json; charset=utf-8"
		E o corpo da resposta deve corresponder ao formato JSON API
		E o corpo da resposta deve conter uma mensagem informando que o acesso foi negado
		
	Cenário: Quando o usuário autenticado tenta alterar o seu email
		Dado que o usuário está autenticado no sistema através do email "johndoe@exemplo.com" e da senha "123456"
		Quando o backend receber uma requisição autenticada para "/user" através do método "PUT" com os parâmetros
		"""
		{
			"email": "novoemaildojohndoe@exemplo.com"
		}
		"""
		Então a resposta deve possuir status "200"
		E a resposta deve possuir o content/type "application/json; charset=utf-8"
		E o corpo da resposta deve corresponder ao formato JSON API
		E o "email" do usuário deve ser "johndoe@exemplo.com"