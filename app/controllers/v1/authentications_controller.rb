# frozen_string_literal: true

module V1
  # Defines actions that involve managing authentication
  class AuthenticationsController < V1::BaseController
    skip_before_action :authenticate_request

    def create
      command = authenticate(authentication_params)
      return render json: result_to_json(command.result) if command.success?

      @user = User.new
      @user.errors.add(:credentials, command.errors)
      render_json_api_error(@user, :unauthorized)
    end

    private

    # Only allow a trusted parameter "white list" through.
    def authentication_params
      params.permit(:email, :password)
    end

    def authenticate(credentials)
      AuthenticateUser.call(credentials)
    end

    def result_to_json(result)
      { data: { attributes: { token: result } } }
    end
  end
end
