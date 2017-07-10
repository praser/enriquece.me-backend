# frozen_string_literal: true

Quando(/^o backend receber uma requisição autenticada para "([^"]*)" através do método "([^"]*)"$/) do |path, method|
  request method.to_sym, path, nil, auth_token
end

Quando(/^o backend receber uma requisição autenticada para "([^"]*)" através do método "([^"]*)" com os parâmetros$/) do |path, method, params|
  request method.to_sym, path, params, auth_token
end

Quando(/^o backend receber uma requisição não autenticada para "([^"]*)" através do método "([^"]*)" com os parâmetros:$/) do |path, method, params|
  request method.to_sym, path, params
end

Quando(/^o backend receber uma requisição não autenticada para "([^"]*)" através do método "([^"]*)"$/) do |path, method|
  request method.to_sym, path
end
