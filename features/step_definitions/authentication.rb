# frozen_string_literal: true

Dado(/^que o usuário se autenticou com a credencial:$/) do |credential|
  authenticate(credential)
end

Dado(/^que o usuário está autenticado no sistema através do email "([^"]*)" e da senha "([^"]*)"$/) do |email, password|
  authenticate(email, password)
end
