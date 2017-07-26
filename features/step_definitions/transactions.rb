# frozen_string_literal: true

Dado(/^a existência das movimentações financeiras abaixo no sistema:$/) do |table|
  table.hashes.each { |data| create_transaction data }
end

Quando(/^o backend receber uma requisição autenticada para o cadastramento de um movimentação financeira de "([^"]*)" na "([^"]*)" com os parâmetros$/) do |category_name, account_name, params|
  category = find_category name: category_name
  account = find_account name: account_name
  request(
    :post,
    default_transactions_path,
    attributes_for_transaction(nil, category, account, params),
    auth_token
  )
end

Quando(/^o backend receber uma requisição autenticada para o cadastramento de um movimentação financeira com parâmetros inválidos$/) do
  request(
    :post,
    default_transactions_path,
    nil,
    auth_token
  )
end

Quando(/^o backend receber uma requisição autenticada para a edição da movimentação financeira "([^"]*)"$/) do |description|
  financial_transaction = find_transaction description: description
  request(
    :put,
    default_transaction_path(financial_transaction),
    nil,
    auth_token
  )
end

Quando(/^o backend receber uma requisição autenticada para a edição da movimentação financeira "([^"]*)" com os parâmetros$/) do |description, params|
  financial_transaction = find_transaction description: description
  request(
    :put,
    default_transaction_path(financial_transaction),
    params,
    auth_token
  )
end

Quando(/^o backend receber uma requisição não autenticada para a edição da movimentação financeira "([^"]*)"$/) do |description|
  financial_transaction = find_transaction description: description
  request(
    :put,
    default_transaction_path(financial_transaction),
    nil,
    nil
  )
end

Quando(/^o backend receber uma requisição não autenticada para exibir dados da transação financeira "([^"]*)"$/) do |description|
  financial_transaction = find_transaction description: description
  request(
    :get,
    default_transaction_path(financial_transaction),
    nil,
    nil
  )
end

Quando(/^o backend receber uma requisição autenticada para remover a movimentação financeira "([^"]*)"$/) do |description|
  financial_transaction = find_transaction(description: description)
  request :delete, default_transaction_path(financial_transaction), nil, auth_token
end

Quando(/^o backend receber uma requisição não autenticada para remover a movimentação financeira "([^"]*)"$/) do |description|
  financial_transaction = find_transaction(description: description)
  request :delete, default_transaction_path(financial_transaction), nil, nil
end

Quando(/^o backend receber uma requisição autenticada para exibir dados da transação financeira "([^"]*)"$/) do |description|
  financial_transaction = find_transaction(description: description)
  request :get, default_transaction_path(financial_transaction), nil, auth_token
end

Quando(/^o backend receber uma requisição autenticada para listar suas movimentações financeiras$/) do
  request :get, default_transactions_path, nil, auth_token
end

Quando(/^o backend receber uma requisição não autenticada para listar movimentações financeiras$/) do
  request :get, default_transactions_path, nil, nil
end

Quando(/^o backend receber uma requisição autenticada para listar suas movimentações financeiras a partir de "([^"]*)"$/) do |start_date|
  request(
    :get,
    default_transactions_since_path(start_date),
    nil,
    auth_token
  )
end

Quando(/^o backend receber uma requisição não autenticada para listar movimentações financeiras a partir de de "([^"]*)"$/) do |start_date|
  request(
    :get,
    default_transactions_since_path(start_date),
    nil,
    nil
  )
end

Quando(/^o backend receber uma requisição autenticada para listar suas movimentações financeiras a partir de "([^"]*)" até "([^"]*)"$/) do |start_date, end_date|
  request(
    :get,
    default_transactions_since_until_path(start_date, end_date),
    nil,
    auth_token
  )
end

Quando(/^o backend receber uma requisição não autenticada para listar movimentações financeiras a partir de "([^"]*)" até "([^"]*)"$/) do |start_date, end_date|
  request(
    :get,
    default_transactions_since_until_path(start_date, end_date),
    nil,
    nil
  )
end

Então(/^a movimentação financeira "([^"]*)" deverá ter sido removida$/) do |description|
  expect(find_transaction(description: description)).to be_nil
end

Então(/^a movimentação financeira "([^"]*)" não deverá ter sido removida$/) do |description|
  expect(find_transaction(description: description)).to_not be_nil
end

Então(/^o campo "([^"]*)" da transação financeira deve ser "([^"]*)"$/) do |field, value|
  field = response_attribute_name_parser(field)
  expect(response_attributes[field].to_s).to eq value.to_s
end

Então(/^a resposta deve exibir todas as minhas movimentações financeiras do mês$/) do
  my_fin_trans = find_transaction_where(
    date: {
      :$gte => Date.today.at_beginning_of_month,
      :$lte => Date.today.at_end_of_month
    },
    user_id: {
      :$eq => find_user(email: 'johndoe@exemplo.com').id.to_s
    }
  )

  expect(response_transaction).to eq my_fin_trans
end

Então(/^a resposta deve exibir todas as minhas movimentações financeiras desde o dia "([^"]*)" até o fim do mês corrente$/) do |start_date|
  my_fin_trans = find_transaction_where(
    date: {
      :$gte => Date.parse(start_date),
      :$lte => Date.today.at_end_of_month
    },
    user_id: {
      :$eq => find_user(email: 'johndoe@exemplo.com').id.to_s
    }
  )

  expect(response_transaction).to eq my_fin_trans
end

Então(/^a resposta deve exibir todas as minhas movimentações financeiras desde o dia "([^"]*)" até o dia "([^"]*)"$/) do |start_date, end_date|
  my_fin_trans = find_transaction_where(
    date: {
      :$gte => Date.parse(start_date),
      :$lte => Date.parse(end_date)
    },
    user_id: {
      :$eq => find_user(email: 'johndoe@exemplo.com').id.to_s
    }
  )

  expect(response_transaction).to eq my_fin_trans
end
