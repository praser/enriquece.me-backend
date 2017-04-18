Dado(/^a existência das contas abaixo no sistema:$/) do |table|
  table.hashes.each do |data|
  	
  	FactoryGirl.create(:account, {
  		name: data['nome'],
  		initial_balance: data['saldo_inicial'],
      bank: Bank.find_by(name: data['banco']),
  		account_type: AccountType.find_by(name: data['tipo']),
  		user: User.find_by(email: data['usuario'])
  	})
  end
end

Quando(/^o backend receber uma requisição autenticada para alterar a conta "([^"]*)" com os parâmetros$/) do |account_name, params|
  header "Content-Type", "application/vnd.api+json"
  header "Authorization", "Bearer #{@token}"

  account = Account.find_by(name: account_name)
  put default_account_path(account), params
end

Quando(/^o backend receber uma requisição não autenticada para alterar a conta "([^"]*)"$/) do |account_name|
  header "Content-Type", "application/vnd.api+json"

  account = Account.find_by(name: account_name)
  put default_account_path(account)
end

Quando(/^o backend receber uma requisição autenticada para o cadastramento de uma conta "([^"]*)" no banco "([^"]*)" com os parâmetros$/) do |account_type, bank, params|
  header "Content-Type", "application/vnd.api+json"
  header "Authorization", "Bearer #{@token}"

  account_type = AccountType.find_by(name: account_type)
  bank = Bank.find_by(name: bank)
  params = JSON.parse(params)
  params['account_type_id'] = account_type.id.to_s
  params['bank_id'] = bank.id.to_s

  post default_accounts_path, params.to_json.to_s
end

Então(/^o campo "([^"]*)" da conta deve ser "([^"]*)"$/) do |field, value|
  body = JSON.parse(last_response.body)

  field = case field
  when "nome" 
    "name"
  when "descricao"
    "description"
  when "saldo inicial"
    "initial-balance"
  else raise "field name unknown in step definions"
  end

  expect(body['data']['attributes'][field].to_s).to eq value.to_s
end