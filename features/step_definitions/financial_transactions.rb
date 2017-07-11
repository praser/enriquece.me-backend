# frozen_string_literal: true

Dado(/^a existência das movimentações financeiras abaixo no sistema:$/) do |table|
  table.hashes.each { |data| create_financial_transaction data }
end

Quando(/^o backend receber uma requisição autenticada para o cadastramento de um movimentação financeira de "([^"]*)" na "([^"]*)" com os parâmetros$/) do |category_name, account_name, params|
  category = find_category name: category_name
  account = find_account name: account_name
  request(
    :post,
    default_financial_transactions_path,
    attributes_for_financial_transaction(nil, category, account, params),
    auth_token
  )
end

Quando(/^o backend receber uma requisição autenticada para o cadastramento de um movimentação financeira com parâmetros inválidos$/) do
  request(
    :post,
    default_financial_transactions_path,
    nil,
    auth_token
  )
end

Quando(/^o backend receber uma requisição autenticada para a edição da movimentação financeira "([^"]*)"$/) do |description|
  financial_transaction = find_financial_transaction description: description
  request(
    :put,
    default_financial_transaction_path(financial_transaction),
    nil,
    auth_token
  )
end

Quando(/^o backend receber uma requisição autenticada para a edição da movimentação financeira "([^"]*)" com os parâmetros$/) do |description, params|
  financial_transaction = find_financial_transaction description: description
  request(
    :put,
    default_financial_transaction_path(financial_transaction),
    params,
    auth_token
  )
end

Quando(/^o backend receber uma requisição não autenticada para a edição da movimentação financeira "([^"]*)"$/) do |description|
  financial_transaction = find_financial_transaction description: description
  request(
    :put,
    default_financial_transaction_path(financial_transaction),
    nil,
    nil
  )
end
