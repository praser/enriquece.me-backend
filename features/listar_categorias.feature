#language: pt
@categoria @listar_categoria
Funcionalidade: Editar categoria
	Para gerenciar suas finanças
	Os usuários podem editar as categorias que tiver cadastrado

	Contexto:
		Dado a existência dos usuários abaixo no sistema:
		| nome       | email                 | senha  |
		| John Doe   | johndoe@exemplo.com   | 123456 |
		| Mike Tyson | miketyson@exemplo.com | 123456 |
		| Rob Stark  | robstark@exemplo.com  | 123456 |
		E a existência das categorais abaixo no sistma:
		| nome			| usuario				|
		| Alimentação	| johndoe@exemplo.com	|
		| Saúde			| johndoe@exemplo.com	|
		| Transporte	| robstark@exemplo.com	|
	
	Cenário: Quando um usuário autenticado solicita a lista das suas categorias
		Dado que o usuário está autenticado no sistema através do email "johndoe@exemplo.com" e da senha "123456"
		Quando o backend receber uma requisição autenticada para "/categories" através do método "GET"
		Então a resposta deve possuir status "200"
		E a resposta deve possuir o content/type "application/json; charset=utf-8"
		E o corpo da resposta deve corresponder ao formato JSON API
		E o a lista deve conter "2" "categorias"
	
	Cenário: Quando um usuário não autenticado solicita a lista de categorias
		Quando o backend receber uma requisição não autenticada para "/categories" através do método "GET"
		Então a resposta deve possuir status "401"
		E a resposta deve possuir o content/type "application/json; charset=utf-8"
		E o corpo da resposta deve corresponder ao formato JSON API
		E o corpo da resposta deve conter uma mensagem informando que o acesso foi negado