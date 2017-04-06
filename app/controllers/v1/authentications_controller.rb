class V1::AuthenticationsController < ApplicationController
  skip_before_action :authenticate_request

  # POST /v1/authentications
  def create
    command = AuthenticateUser.call(authentication_params)

    if command.success?
      render json: {token: command.result}
    else
      render json: {error: command.errors}, status: :unauthorized
    end
  end

  private
    # Only allow a trusted parameter "white list" through.
    def authentication_params
      params.require(:data).require(:attributes).permit(:email, :password)
    end
end
