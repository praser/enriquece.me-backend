# frozen_string_literal: true

Dado(/^a existência das subcategorias abaixo no sistema:$/) do |table|
  table.hashes.each do |data|
    category = find_category name: data['categoria']
    create_subcategory category, data
  end
end

Quando(/^o backend receber uma requisição autenticada para o cadastramento de uma subcategoria de "([^"]*)" com os parâmetros$/) do |category_name, params|
  category = find_category(name: category_name)
  request(
    :post,
    default_subcategories_url,
    attributes_for_subcategory(category, params),
    auth_token
  )
end

Quando(/^o backend receber uma requisição autenticada para alterar a subcategoria "([^"]*)" com os parâmetros$/) do |subcategory_name, params|
  subcategory = find_subcategory(name: subcategory_name)
  subcategory.assign_attributes(JSON.parse(params))
  request(
    :put,
    default_subcategory_url(subcategory),
    subcategory.to_json,
    auth_token
  )
end

Quando(/^o backend receber uma requisição autenticada para remover a subcategoria "([^"]*)"$/) do |subcategory_name|
  subcategory = find_subcategory(name: subcategory_name)
  request :delete, default_subcategory_url(subcategory), nil, auth_token
end

Quando(/^o backend receber uma requisição não autenticada para alterar a subcategoria "([^"]*)"$/) do |subcategory_name|
  subcategory = find_subcategory(name: subcategory_name)
  request :put, default_subcategory_url(subcategory)
end

Quando(/^o backend receber uma requisição não autenticada para remover a subcategoria "([^"]*)"$/) do |subcategory_name|
  subcategory = find_subcategory(name: subcategory_name)
  request :delete, default_subcategory_url(subcategory)
end

Então(/^a subcategoria "([^"]*)" deve ser cadastrada$/) do |category_name|
  expect(find_subcategory(name: category_name)).to_not be_nil
end

Então(/^a subcategoria "([^"]*)" deve estar relacionada a "([^"]*)"$/) do |subcategory_name, category_name|
  subcategory = find_subcategory(name: subcategory_name)
  category = find_category(name: category_name)

  expect(subcategory.category).to eq category
end

Então(/^a subcategoria "([^"]*)" deve estar presente na resposta\.$/) do |subcategory_name|
  subcategory = find_subcategory(name: subcategory_name)
  expect(response_attributes['name']).to eq subcategory.name
end

Então(/^o campo "([^"]*)" da subcategoria deve ser "([^"]*)"$/) do |field, value|
  field = response_attribute_name_parser(field)
  expect(response_attributes[field].to_s).to eq value.to_s
end

Então(/^a subcategoria "([^"]*)" deverá ter sido removida$/) do |subcategory_name|
  expect(find_subcategory(name: subcategory_name)).to be_nil
end
