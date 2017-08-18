# frozen_string_literal: true

module V1
  # Defines actions that involve managing authentication
  class AuthenticationsController < V1::BaseController
    skip_before_action :authenticate_request

=begin
  @apiDefine AuthenticationParams
  @apiParam {String} email User's email
  @apiParam {String} password User's password
  @apiParamExample {json} Look at this example of json for user authentication
  Sometimes an example is better than 1000 words...

  {
    "email": "usuario@enriquece.me",
    "password": "123456"
  }
=end

=begin
  @apiDefine AuthenticationObjectExemple
  @apiSuccessExample {json} Here is an example of response when everithing is ok
  If you did everithing right congratulatuons! Your response must look like the
  one bellow:

  HTTP/1.1 200 OK
  {
    "data": {
      "attributes": {
        "token": "<token>"
      }
    }
  }
=end

=begin
  @apiDescription This is the end point where you will dispatch a post request
  whith user credentials for authentication. If the http code of the response is
  200, the server will return a token that you need to attach in every header of
  authenticated request. So keep the token safe and accessible.The process is
  pretty simple and well documented. Hope you enjoy.

  @apiVersion 1.0.0
  @api {post} /v1/authenticate Authenticate user
  @apiName CreateAuthentication
  @apiGroup Authentication

  @apiExample {curl} I know that some times you need an example. Me too :)
  curl -i
  -X POST
  -H 'CONTENT-TYPE: application/json'
  -d '{"email": "johndoe@enriquece.me", "password": "123456"}'
  https://api.enriquece.me/v1/authenticate

  @apiSuccess {Object} data
  @apiSuccess {Object} data.attributes
  @apiSuccess {String} data.attributes.token This is that token I told you
  earlier. Remenber to keep it safe and accessible, ok?

  @apiUse AuthenticationParams
  @apiUse UnauthenticatedHeader
  @apiUse AuthenticationObjectExemple
  @apiUse UnprocessableEntity
=end
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
    rescue => error
      resource = User.new
      resource.errors.add(:credentials, error.message)
      render_json_api_error(resource, :unauthorized)
    end

    def result_to_json(result)
      { data: { attributes: { token: result } } }
    end
  end
end
