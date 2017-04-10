Então(/^a resposta deve possuir status "([^"]*)"$/) do |status|
  expect(last_response.status).to eq status.to_i
end

Então(/^a resposta deve possuir o content\/type "([^"]*)"$/) do |content_type|
  expect(last_response.header["Content-Type"]).to eq content_type
end

Então(/^o corpo da resposta deve possuir o formato abaixo:$/) do |schema|
  JSON::Validator.validate(schema, JSON.parse(last_response.body))
end

Então(/^o corpo da resposta deve conter uma mensagem informando que o acesso foi negado$/) do
  body = JSON.parse(last_response.body)
  expect(body["errors"][0]["detail"]).to eq "Not Authorized"
end

Então(/^o corpo da resposta deve conter uma mensagem informando que o campo "([^"]*)" "([^"]*)"$/) do |field, message|
  body = JSON.parse(last_response.body)
  
  case field.downcase
  when "nome"
  	field = "/data/attributes/name"
	when "email"
  	field = "/data/attributes/email"
  when "senha"
  	field = "/data/attributes/password"
  end

  case message.downcase
	when "deve ser informado"
		message = "can't be blank"
	when "já está em uso"
		message = "is already taken"
	end

	expect(body["errors"][0]["source"]["pointer"]).to eq field
	expect(body["errors"][0]["detail"]).to eq message
end