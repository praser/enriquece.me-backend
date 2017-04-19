# enriqueca.me (Backend)

Api contendo as lógicas de negócio do gerenciador financeiro que pretende transformar os usuários em poupadores e aplicadores.

## Começando

Estas instruções irão te fornecer uma cópia do projeto instalado e rodando no seu ambiente local com propósitos de desenvolvimento e testes.

### Pré requisitos

Os seguintes softwares devem estar instalados e configurados para que seja possível executar o projeto:

* MongoDB v3.4.3
* Ruby v2.4.1
* Git

Orientações para a instação dos softwares listados acima podem ser encontrados nos seus respectivos websites

* [MongoDB](https://www.mongodb.com/)
* [Ruby](https://www.ruby-lang.org)
* [Git](https://git-scm.com/)

### Instalação

Estando todos os pré requisitos instalados e configurados passaremos para a instalação do projeto.

Faça o clone do repositório do projeto:
```
git clone https://github.com/praser/enriqueca.me-backend
```

Instale a Gem Bundler para baixar as dependências do projeto
```
gem install bundler
```

Acesse a pasta onde o repositório foi clonado
```
cd enriqueca.me-backend/
```

Instale as dependências
```
bundle install
```

Altere o arquivo __config/mongoid.yml__ conforme a configuração local da sua instalação do MongoDB

Semeie o banco de dados executando o comando abaixo
```
rake db:seed
```

Pronto! Agora você deve ter uma cópia funcional do backend rodando na sua máquina local.

Inicie o servidor e faça algumas requisições:
```
rails s
```

Para testar se tudo está funcionando corretamente, tente cadastrar um novo usuário:

```
curl -H "Content-Type: application/json" -X POST -d '{"name": "John Doe", email":"johndoe@exemple.com","password":"senha-marota"}' http://localhost:3000/users
```

## Rodando os testes

Este sistema é construído seguindo a técnica do BDD (Behavior Drivern Development) ou desenvolvimento guiado por comportamento. Para tal utilizamos Cucumber e RSpec para testes de aceitação e testes funcionais respectivamente.


### Testes de aceitacão

Para executar a suíte de testes de aceitação, execute o comando abaixo no console:
```
rake cucumber
```

### Testes funcionais

Para executar a suíte de testes funcionais, execute o comando abaixo no console:
```
rake spec
```

## Deployment

Atualmente o backend ainda não está em produção. A versão de desenvolvimento está hospedada no Heroku e pode ser acessada através do endereço [http://www.enriqueca.me](http://www.enriqueca.me)

## Construído com:

* [Ruby](https://www.ruby-lang.org/) - O melhor amigo do programador
* [Rails](http://rubyonrails.org/) - A web-application framework that includes everything needed to create database-backed web applications according to the Model-View-Controller (MVC) pattern.
* [MongoDB](https://www.mongodb.com/) - For GIANT ideas

## Contribuindo

Por favor leia [CONTRIBUTING.md](https://gist.github.com/PurpleBooth/b24679402957c63ec426) (em inglês) para detalhes sobre a nossa conduta de codificação, e o processo de submeter pull requests para nós.

## Versionamento

Nós utilizamos [SemVer](http://semver.org/) para versionamneto. Para listar as versões disponíveis veja as [tags deste repositório](https://github.com/praser/enriqueca.me-backend/tags). 

## Autores

* **Breno Sales** - *Programação* - [brenosales](https://github.com/brenosales)
* **Eduardo Almeida** - *Programação* - [eduardo-almeida-II](https://github.com/eduardo-almeida-II)
* **Rubens Praser Júnior** - *Programação* - [praser](https://github.com/praser)

Veja também a lista de [contribuidores](https://github.com/praser/enriqueca.me-backend/graphs/contributors) que participam deste projeto.

## Licença

Este é um software proprietário e toda e qualquer distribuição ou modificação deve passar pela crivo dos autores.