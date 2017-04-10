Dado(/^a existência dos usuários abaixo no sistema:$/) do |table|
  table.hashes.each do |data|
  	FactoryGirl.create(:user,{
  		name: data['nome'],
  		email: data['email'],
  		password: data['senha']
  	})
  end
end

Dado(/^o cadastro de novo usuário com os dados:$/) do |table|
  table.hashes.each do |data|
  	@attributes = FactoryGirl.attributes_for(:user, {
  		name: data['nome'],
  		email: data['email'],
  		password: data['senha']
  	}).to_json
  end
end

Dado(/^a existência de um usuário cadastrado anteriormente com o mesmo email$/) do
  FactoryGirl.create(:user, {email: JSON.parse(@attributes)['email']})
end

Dado(/^que o backend não permite que o email do usuário seja alterado$/) do
end


Então(/^o "([^"]*)" do usuário deve ser "([^"]*)"$/) do |field, value|
	body = JSON.parse(last_response.body)
	
	expect(body["data"]["type"]).to eq("users")

  case field.downcase
  when "nome"	
  	expect(body["data"]["attributes"]["name"]).to eq(value)
  when "email"	
  	expect(body["data"]["attributes"]["email"]).to eq(value)
  else raise "Unknow field '#{field}' for User in step definitions"
  end
end