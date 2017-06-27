# frozen_string_literal: true

module AuthenticationHelper
  @@response

  def authenticate(email, password)
    credentials = {
      email: email,
      password: password
    }.to_json

    @@response = request(:post, default_authenticate_path, credentials)
  end

  def auth_token
    JSON.parse(@@response.body)['data']['attributes']['token']
  end
end

World AuthenticationHelper
