# frozen_string_literal: true

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
