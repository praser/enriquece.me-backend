class V1::AuthenticationsController < V1::BaseController
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
        render_json_api_error(@user, :unauthorized)
      end
    rescue => e
      resource = User.new
      resource.errors.add(:credentials, 'Could not find any user with the credentials provided')
      render_json_api_error(resource, :unauthorized)
    end

  end

  private
    # Only allow a trusted parameter "white list" through.
    def authentication_params
      params.permit(:email, :password)
    end
end
