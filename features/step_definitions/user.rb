Dado(/^o cadastro de novo usuário com os dados:$/) do |table|
  table.hashes.each do |data|
  	@user_attributes = FactoryGirl.attributes_for(:user, {
  		name: data['nome'],
  		email: data['email'],
  		password: data['senha']
  	})
  end
end

Dado(/^a existência de um usuário cadastrado anteriormente com o mesmo email$/) do
  FactoryGirl.create(:user, {email: @user_attributes[:email]})
end

Quando(/^o backend receber uma requisição para "([^"]*)" através do método "([^"]*)"$/) do |path, method|
  case method.upcase
  when 'POST'
  	post path, @user_attributes, headers: { 'Content-Type' => 'application/vnd.api+json' }
  end
end

Então(/^a resposta deve possuir status "([^"]*)"$/) do |status|
  expect(last_response.status).to eq status.to_i
end

Então(/^a resposta deve possuir o content\/type "([^"]*)"$/) do |content_type|
  expect(last_response.header["Content-Type"]).to eq content_type
end

Então(/^o corpo da resposta deve possuir o formato abaixo:$/) do |schema|
  JSON::Validator.validate(schema, JSON.parse(last_response.body))
end
