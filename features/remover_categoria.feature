#language: pt
@categoria @remover_categoria
Funcionalidade: Remover categoria
	Para melhor gerenciar suas finanças
	Os usuários podem remover suas categorias

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
	
	Cenário: Um usuário autenticado tenta remover uma de suas categorias
		Dado que o usuário está autenticado no sistema através do email "johndoe@exemplo.com" e da senha "123456"
		Quando o backend receber uma requisição autenticada para remover a categoria "Alimentação"
		Então a resposta deve possuir status "204"
		E a categoria "Alimentação" deverá ter sido removida
	
	Cenário: Um usuário não autenticado tenta remover uma categoria
		Quando o backend receber uma requisição não autenticada para remover a categoria "Alimentação"
		Então a resposta deve possuir status "401"
		E o corpo da resposta deve corresponder ao formato JSON API
		E o corpo da resposta deve conter uma mensagem informando que o acesso foi negado

	Cenário: Um usuário autenticado tenta remover uma categoria que não é sua
		Dado que o usuário está autenticado no sistema através do email "johndoe@exemplo.com" e da senha "123456"
		Quando o backend receber uma requisição autenticada para remover a categoria "Transporte"
		Então a resposta deve possuir status "401"
		E o corpo da resposta deve corresponder ao formato JSON API
		E o corpo da resposta deve conter uma mensagem informando que o acesso foi negado