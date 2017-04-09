class V1::AuthenticationsController < ApplicationController
  skip_before_action :authenticate_request

  # POST /v1/authentications
  def create
    begin
      command = AuthenticateUser.call(authentication_params)

      if command.success?
        render json: {data: { attributes: {token: command.result } } }
      else
        @user = User.new
        @user.errors.add(:credentials, command.errors)
        render json: @user, status: :unauthorized, adapter: :json_api, serializer: ActiveModel::Serializer::ErrorSerializer
      end
    rescue => e
      resource = User.new
      resource.errors.add(:credentials, 'Could not find any user with the credentials provided')
      render json: resource, status: :unauthorized, adapter: :json_api, serializer: ActiveModel::Serializer::ErrorSerializer
    end

  end

  private
    # Only allow a trusted parameter "white list" through.
    def authentication_params
      params.permit(:email, :password)
    end
end
