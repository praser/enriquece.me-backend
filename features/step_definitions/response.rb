# frozen_string_literal: true

Então(/^a resposta deve possuir status "([^"]*)"$/) do |status|
  expect(last_response.status).to eq status.to_i
end

Então(/^a resposta deve possuir o content type "([^"]*)"$/) do |content_type|
  expect(last_response.header['Content-Type']).to eq content_type
end

Então(/^o corpo da resposta deve corresponder ao formato JSON API$/) do
  schema = JSON.parse(File.read(Rails.root.join('public', 'api-schema.json').to_s))
  JSON::Validator.validate!(schema, JSON.parse(last_response.body))
end

Então(/^o corpo da resposta deve conter uma mensagem informando que o acesso foi negado$/) do
  body = JSON.parse(last_response.body)
  expect(body['errors'][0]['detail']).to eq 'Not Authorized'
end

Então(/^o corpo da resposta deve conter uma mensagem informando que o campo "([^"]*)" "([^"]*)"$/) do |field, message|
  body = JSON.parse(last_response.body)
  json_node = '/data/attributes/'

  case field.downcase
  when 'nome' then field = 'name'
  when 'email' then field = 'email'
  when 'senha' then field = 'password'
  when 'banco' then field = 'bank'
  when 'saldo inicial' then field = 'initial-balance'
  when 'tipo de conta' then field = 'account-type'
  end

  field = "#{json_node}#{field}"

  case message.downcase
  when 'deve ser informado' then message = "can't be blank"
  when 'já está em uso' then message = 'is already taken'
  end

  expect(body['errors'].map { |el| el['source']['pointer'] }).to include(field)
  expect(body['errors'].map { |el| el['detail'] }[body['errors'].map { |el| el['source']['pointer'] }.index field]).to include(message)
end

Então(/^o a lista deve conter "([^"]*)" "([^"]*)"$/) do |amount, type|
  amount = amount.to_i

  case type
  when 'contas' then type = 'account'
  when 'categorias' then type = 'category'
  end

  body = JSON.parse(last_response.body)

  expect(body['data'].map { |el| el['type'] }.uniq.size).to eq 1
  expect(body['data'].map { |el| el['type'] }.uniq[0]).to eq type
  expect(body['data'].map { |el| el['attributes'] }.size).to eq amount
end
