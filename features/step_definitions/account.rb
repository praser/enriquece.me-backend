# frozen_string_literal: true

Dado(/^a existência das contas abaixo no sistema:$/) do |table|
  table.hashes.each { |data| create_account data }
end

Quando(/^o backend receber uma requisição autenticada para alterar a conta "([^"]*)" com os parâmetros$/) do |account_name, params|
  account = find_account(name: account_name)
  request :put, default_account_url(account), params, auth_token
end

Quando(/^o backend receber uma requisição autenticada para exibir dados da conta "([^"]*)"$/) do |account_name|
  account = find_account(name: account_name)
  request :get, default_account_url(account), nil, auth_token
end

Quando(/^o backend receber uma requisição autenticada para remover a conta "([^"]*)"$/) do |account_name|
  account = find_account(name: account_name)
  request :delete, default_account_url(account), nil, auth_token
end

Quando(/^o backend receber uma requisição não autenticada para alterar a conta "([^"]*)"$/) do |account_name|
  account = find_account(name: account_name)
  request :put, default_account_url(account), nil, auth_token
end

Quando(/^o backend receber uma requisição não autenticada para exibir dados da conta "([^"]*)"$/) do |account_name|
  account = find_account(name: account_name)
  request :get, default_account_url(account)
end

Quando(/^o backend receber uma requisição não autenticada para remover a conta "([^"]*)"$/) do |account_name|
  account = find_account(name: account_name)
  request :delete, default_account_url(account)
end

Quando(/^o backend receber uma requisição autenticada para o cadastramento de uma conta "([^"]*)" no banco "([^"]*)" com os parâmetros$/) do |account_type, bank, params|
  account_type = find_account_type(name: account_type)
  bank = find_bank(name: bank)
  attributes = attributes_for_account(account_type, bank, params)
  request :post, default_accounts_url, attributes, auth_token
end

Então(/^o campo "([^"]*)" da conta deve ser "([^"]*)"$/) do |attribute, value|
  field = account_attribute_name_parser(attribute)
  expect(response_attributes[field].to_s).to eq value.to_s
end
