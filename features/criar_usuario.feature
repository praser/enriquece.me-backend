#language: pt
@usuario @criar_usuario
Funcionalidade: Cadastrar usuário
	Para gerenciar suas finanças
	Os usuários devem se cadastrar no sistema

	Cenário: Usando dados válidos
		Dado o cadastro de novo usuário com os dados:
		| nome     | email               | senha  |
		| John Doe | johndoe@exemplo.com | 123456 |
		Quando o backend receber uma requisição para "/users" através do método "POST"
		Então a resposta deve possuir status "201"
		E a resposta deve possuir o content/type "application/json; charset=utf-8"
		E o corpo da resposta deve corresponder ao formato JSON API
	
	Cenário: Deixando de informar o nome
		Dado o cadastro de novo usuário com os dados:
		| nome     | email               | senha  |
		|          | johndoe@exemplo.com | 123456 |
		Quando o backend receber uma requisição para "/users" através do método "POST"
		Então a resposta deve possuir status "422"
		E a resposta deve possuir o content/type "application/json; charset=utf-8"
		E o corpo da resposta deve corresponder ao formato JSON API
		E o corpo da resposta deve conter uma mensagem informando que o campo "nome" "deve ser informado" 
	
	Cenário: Deixando de informar o email
		Dado o cadastro de novo usuário com os dados:
		| nome     | email               | senha  |
		| John Doe |                     | 123456 |
		Quando o backend receber uma requisição para "/users" através do método "POST"
		Então a resposta deve possuir status "422"
		E a resposta deve possuir o content/type "application/json; charset=utf-8"
		E o corpo da resposta deve corresponder ao formato JSON API
		E o corpo da resposta deve conter uma mensagem informando que o campo "email" "deve ser informado" 
	
	Cenário: Deixando de informar a senha
		Dado o cadastro de novo usuário com os dados:
		| nome     | email               | senha  |
		| John Doe | johndoe@exemplo.com |        |
		Quando o backend receber uma requisição para "/users" através do método "POST"
		Então a resposta deve possuir status "422"
		E a resposta deve possuir o content/type "application/json; charset=utf-8"
		E o corpo da resposta deve corresponder ao formato JSON API
		E o corpo da resposta deve conter uma mensagem informando que o campo "senha" "deve ser informado" 
	
	Cenário: Usando um email repetido
		Dado o cadastro de novo usuário com os dados:
		| nome     | email               | senha  |
		| John Doe | johndoe@exemplo.com | 123456 |
		E a existência de um usuário cadastrado anteriormente com o mesmo email
		Quando o backend receber uma requisição para "/users" através do método "POST"
		Então a resposta deve possuir status "422"
		E a resposta deve possuir o content/type "application/json; charset=utf-8"
		E o corpo da resposta deve corresponder ao formato JSON API
		E o corpo da resposta deve conter uma mensagem informando que o campo "email" "já está em uso" 