# frozen_string_literal: true

Dado(/^a existência das categorias abaixo no sistma:$/) do |table|
  table.hashes.each do |data|
    user = find_user(email: data['usuario'])
    create_category(user, data)
  end
end

Quando(/^o backend receber uma requisição autenticada para alterar a categoria "([^"]*)" com os parâmetros$/) do |category_name, params|
  category = find_category(name: category_name)
  request :put, default_category_url(category), params, auth_token
end

Quando(/^o backend receber uma requisição não autenticada para alterar a categoria "([^"]*)"$/) do |category_name|
  category = find_category(name: category_name)
  request :put, default_category_url(category)
end

Quando(/^o backend receber uma requisição autenticada para remover a categoria "([^"]*)"$/) do |category_name|
  category = find_category(name: category_name)
  request :delete, default_category_url(category), nil, auth_token
end

Quando(/^o backend receber uma requisição não autenticada para remover a categoria "([^"]*)"$/) do |category_name|
  category = find_category(name: category_name)
  request :delete, default_category_url(category)
end

Então(/^a categoria "([^"]*)" deve ser cadastrada$/) do |category_name|
  expect(find_category(name: category_name)).to_not be_nil
end

Então(/^a categoria "([^"]*)" deve estar presente na resposta\.$/) do |category_name|
  category = find_category(name: category_name)
  expect(response_attributes['name']).to eq category.name
end

Então(/^a categoria "([^"]*)" deverá ter sido removida$/) do |category_name|
  expect(find_category(name: category_name)).to be_nil
end
