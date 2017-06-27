# frozen_string_literal: true

Então(/^a resposta deve possuir status "([^"]*)"$/) do |status|
  expect(last_response.status).to eq status.to_i
end

Então(/^a resposta deve possuir o content type "([^"]*)"$/) do |content_type|
  expect(last_response.header['Content-Type']).to eq content_type
end

Então(/^o corpo da resposta deve corresponder ao formato JSON API$/) do
  expect(response_is_valid?).to be_truthy
end

Então(/^o corpo da resposta deve conter uma mensagem informando que o acesso foi negado$/) do
  expect(response_errors[0]['detail']).to eq 'Not Authorized'
end

Então(/^o corpo da resposta deve conter uma mensagem informando que o campo "([^"]*)" "([^"]*)"$/) do |field, message|
  body = JSON.parse(last_response.body)
  attribute = "/data/attributes/#{response_attribute_name_parser field}"
  text = response_attribute_message_parser message

  expect(body['errors'].map { |el| el['source']['pointer'] }).to include(attribute)
  expect(body['errors'].map { |el| el['detail'] }[body['errors'].map { |el| el['source']['pointer'] }.index attribute]).to include(text)
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
