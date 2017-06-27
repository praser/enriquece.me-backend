# frozen_string_literal: true

module ResponseHelper
  def response_attributes
    body = JSON.parse(last_response.body)
    body['data']['attributes']
  end

  def response_errors
    body = JSON.parse(last_response.body)
    body['errors']
  end

  def response_is_valid?
    schema = JSON.parse(File.read(Rails.root.join('public', 'api-schema.json').to_s))
    JSON::Validator.validate!(schema, JSON.parse(last_response.body))
  end

  def response_attribute_name_parser(attribute)
    case attribute.downcase
    when 'nome' then 'name'
    when 'email' then 'email'
    when 'senha' then 'password'
    when 'banco' then 'bank'
    when 'saldo inicial' then 'initial-balance'
    when 'tipo de conta' then 'account-type'
    else raise 'attribute name unknown in response'
    end
  end

  def response_attribute_message_parser(message)
    case message.downcase
    when 'deve ser informado' then "can't be blank"
    when 'já está em uso' then 'is already taken'
    end
  end
end

World ResponseHelper
