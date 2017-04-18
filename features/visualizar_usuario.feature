#language: pt
@usuario @visualizar_usuario
Funcionalidade: Visualizar dados do usuário
	Para gerenciar sua conta na aplicação
	Os usuários devem visualizar os dados das suas contas

	Contexto:
		Dado a existência dos usuários abaixo no sistema:
		| id | nome       | email                 | senha  |
		| 1  | John Doe   | johndoe@exemplo.com   | 123456 |
		| 2  | Mike Tyson | miketyson@exemplo.com | 123456 |
		| 3  | Rob Stark  | robstark@exemplo.com  | 123456 |

	Cenário: Quando um usuário solicita acesso aos seus próprios dados
		Dado que o usuário está autenticado no sistema através do email "johndoe@exemplo.com" e da senha "123456"
		Quando o backend receber uma requisição autenticada para "/user" através do método "GET"
		Então a resposta deve possuir status "200"
		E a resposta deve possuir o content/type "application/json; charset=utf-8"
		E o corpo da resposta deve corresponder ao formato JSON API
		E o "nome" do usuário deve ser "John Doe"
		E o "email" do usuário deve ser "johndoe@exemplo.com"
	
	Cenário: Quando um usuário solicita acesso aos seus próprios dados sem estar autenticado
		Quando o backend receber uma requisição não autenticada para "/user" através do método "GET"
		Então a resposta deve possuir status "401"
		E a resposta deve possuir o content/type "application/json; charset=utf-8"
		E o corpo da resposta deve corresponder ao formato JSON API
		E o corpo da resposta deve conter uma mensagem informando que o acesso foi negado