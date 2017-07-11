#language: pt
@usuario @criar_usuario
Funcionalidade: Cadastrar usuário
  Para gerenciar suas finanças
  Os usuários devem se cadastrar no sistema

  Cenário: Usando dados válidos
    Quando o backend receber uma requisição não autenticada para "/users" através do método "POST" com os parâmetros:
    """
    {
      "name": "Rob Stark",
      "email": "robstart@exemplo.com",
      "password": "123456"
    }
    """
    Então a resposta deve possuir status "201"
    E a resposta deve possuir o content type "application/json; charset=utf-8"
    E o corpo da resposta deve corresponder ao formato JSON API
  
  Cenário: Deixando de informar o nome
    Quando o backend receber uma requisição não autenticada para "/users" através do método "POST" com os parâmetros:
    """
    {
      "email": "johndoe@exemplo.com",
      "password": "123456"
    }
    """
    Então a resposta deve possuir status "422"
    E a resposta deve possuir o content type "application/json; charset=utf-8"
    E o corpo da resposta deve corresponder ao formato JSON API
    E o corpo da resposta deve conter uma mensagem informando que o campo "nome" "deve ser informado" 
  
  Cenário: Deixando de informar o email
    Quando o backend receber uma requisição não autenticada para "/users" através do método "POST" com os parâmetros:
    """
    {
      "name": "John Doe",
      "password": "123456"
    }
    """
    Então a resposta deve possuir status "422"
    E a resposta deve possuir o content type "application/json; charset=utf-8"
    E o corpo da resposta deve corresponder ao formato JSON API
    E o corpo da resposta deve conter uma mensagem informando que o campo "email" "deve ser informado" 
  
  Cenário: Deixando de informar a senha
    Quando o backend receber uma requisição não autenticada para "/users" através do método "POST" com os parâmetros:
    """
    {
      "name": "John Doe",
      "email": "johndoe@exemplo.com"
    }
    """
    Então a resposta deve possuir status "422"
    E a resposta deve possuir o content type "application/json; charset=utf-8"
    E o corpo da resposta deve corresponder ao formato JSON API
    E o corpo da resposta deve conter uma mensagem informando que o campo "senha" "deve ser informado" 
  
  Cenário: Usando um email repetido
    Dada a exitência de um usuário cadastrados com os dados:
  | nome     | email               | senha  |
  | John Doe | johndoe@exemplo.com | 123456 |
    Quando o backend receber uma requisição não autenticada para "/users" através do método "POST" com os parâmetros:
    """
    {
      "name": "John Doe",
      "email": "johndoe@exemplo.com",
      "password": "123456"
    }
    """
    Então a resposta deve possuir status "422"
    E a resposta deve possuir o content type "application/json; charset=utf-8"
    E o corpo da resposta deve corresponder ao formato JSON API
    E o corpo da resposta deve conter uma mensagem informando que o campo "email" "já está em uso" 