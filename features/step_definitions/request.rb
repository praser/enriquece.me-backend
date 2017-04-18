Quando(/^o backend receber uma requisição para "([^"]*)" através do método "([^"]*)"$/) do |path, method|
	header "Content-Type", "application/vnd.api+json"
  
  case method.upcase
  when 'POST'
  	post path, @attributes
  when 'GET'
  	get path
  else raise "HTTP method unknown in step definions"
  end
end

Quando(/^o backend receber uma requisição autenticada para "([^"]*)" através do método "([^"]*)"$/) do |path, method|
  header "Content-Type", "application/vnd.api+json"
  header "Authorization", "Bearer #{@token}"	

  case method.upcase
  when 'GET'
  	get path
  else raise "HTTP method unknown in step definions"  	
  end
end

Quando(/^o backend receber uma requisição autenticada para "([^"]*)" através do método "([^"]*)" com os parâmetros$/) do |path, method, params|
  header "Content-Type", "application/vnd.api+json"
  header "Authorization", "Bearer #{@token}"

  case method.upcase
  when "PUT"
  	put path, params
  when "POST"
    post path, params
  else raise "HTTP method unknown in step definions"  	
  end
end

Quando(/^o backend receber uma requisição não autenticada para "([^"]*)" através do método "([^"]*)"$/) do |path, method|
  header "Content-Type", "application/vnd.api+json"
  
  case method.upcase
  when 'POST'
  	post path, @attributes
  when 'GET'
  	get path
  else raise "HTTP method unknown in step definions"
  end
end


Dado(/^que o usuário está autenticado no sistema através do email "([^"]*)" e da senha "([^"]*)"$/) do |email, senha|
  credentials = {
  	email: email,
  	password: senha
  }.to_json

  header 'Content-Type', 'application/vnd.api+json'
  post default_authenticate_path, credentials
  @token = JSON.parse(last_response.body)["data"]["attributes"]["token"]
end