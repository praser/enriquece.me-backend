# frozen_string_literal: true

module AuthenticationHelper
  @@response

  def authenticate(*args)
    case args.size
    when 1 then authenticate_by_credential(*args)
    when 2 then authenticate_by_email_password(*args)
    else raise 'Unknown argument set'
    end
  end

  def auth_token
    JSON.parse(@@response.body)['data']['attributes']['token']
  end

  private

  def authenticate_by_email_password(email, password)
    credentials = {
      email: email,
      password: password
    }.to_json

    @@response = request :post, default_authenticate_path, credentials
  end

  def authenticate_by_credential(credential)
    @@response = request :post, default_authenticate_path, credential
  end
end

World AuthenticationHelper
