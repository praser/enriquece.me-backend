# frozen_string_literal: true

Dado(/^a existência dos usuários abaixo no sistema:$/) do |table|
  table.hashes.each do |data|
    FactoryGirl.create(
      :user,
      name: data['nome'],
      email: data['email'],
      password: data['senha']
    )
  end
end

Dado(/^a exitência de um usuário cadastrados com os dados:$/) do |table|
  table.hashes.each do |data|
    create_user(data)
  end
end

Dado(/^o cadastro de novo usuário com os dados:$/) do |table|
  table.hashes.each do |data|
    create_user(data)
  end
end

Dado(/^a existência de um usuário cadastrado anteriormente com o email "([^"]*)"$/) do |email|
  FactoryGirl.create(:user, email: email)
end

Então(/^o "([^"]*)" do usuário deve ser "([^"]*)"$/) do |field, value|
  body = JSON.parse(last_response.body)

  expect(body['data']['type']).to eq('user')

  case field.downcase
  when 'nome'
    expect(body['data']['attributes']['name']).to eq(value)
  when 'email'
    expect(body['data']['attributes']['email']).to eq(value)
  else raise "Unknow field '#{field}' for User in step definitions"
  end
end
