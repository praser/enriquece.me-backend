# frozen_string_literal: true

module V1
  # Defines actions that involve user management
  class UsersController < V1::BaseController
    before_action :set_user, only: %i[show update destroy]
    skip_before_action :authenticate_request, only: :create

=begin
  @apiDefine UserAttributes
  @apiSuccess {String} data.attributes.name User's full name
  @apiSuccess {String} data.attributes.email User's e-mail
=end

=begin
  @apiDefine UserParams
  @apiParam {String} name Fill with user's full name
  @apiParam {String} email Fill with user's e-mail
  @apiParam {String{6..20}} password FIll with User's password
  @apiParamExample {json} Look at this example of json for user request body:
  You must be curious to see how a user request body looks like...
  Don't worry, here is an example:

  {
    "name": "John Doe",
    "email": "johndoe@enriquece.me",
    "password": "123456"
  }
=end

=begin
  @apiDefine UserObjectExemple
  @apiSuccessExample {json} Here is an example of response when everithing is ok
  If you did everithing right congratulatuons! Your response must look like the
  one bellow:

  HTTP/1.1 200 OK
  {
    "data": {
      "id": "598c3c6ec54c8e0004f66519",
      "type": "user",
      "attributes": {
        "name": "John Doe",
        "email": "johndoe@enriquece.me"
      }
    }
  }
=end

=begin
  @apiDescription This end point is responsible for showing users informations.
  It shows data about the user authenticated over the token provided in the
  request headers. The proccess to obtain that data is pretty simple and well
  described.
  In summary all you need to do is trigger a get request as explained below.

  @apiVersion 1.0.0
  @api {get} /v1/user Show user
  @apiName ShowUser
  @apiGroup Users
  @apiPermission authenticated users only

  @apiExample {curl} Needing an example big boy? Here we go!
  Just don't forget of replacing the <token> key with a valid token ok?
  Maybe you can be asking yourself at this point: What f*** is a token? In that
  case don't worry, go ahead and take a look in the authentication section of
  our documentation.

  curl -i
  -H 'CONTENT-TYPE: application/json'
  -H 'AUTHORIZATION: Bearer <token>'
  https://api.enriquece.me/user

  @apiUse AuthenticatedHeader
  @apiUse JsonApiObject
  @apiUse JsonApiObjectAttributes
  @apiUse UserAttributes
  @apiUse UserObjectExemple
  @apiUse UnauthorizedError
=end
    def show
      render json: @user
    end

=begin
  @apiDescription This end point is responsible for creating new users accounts.
  An user account is necessary to allow people to have access in another
  features in the application.
  The proccess of creating a new account is pretty simple and well described.
  In summary all you need to do is trigger a post request as explained below.

  @apiVersion 1.0.0
  @api {post} /v1/users Create user
  @apiName CreateUser
  @apiGroup Users

  @apiExample {curl} Here is example of usage. Simple as it should be!
  Of course the data below is an example, so you already know that is
  necessary replace them with yours.

  curl -i
  -X POST
  -H 'CONTENT-TYPE: application/json'
  -d '{"name": "John Doe", "email": "johndoe@email.com", "password": "123456"}'
  https://api.enriquece.me/v1/users

  @apiSuccessExample {json} Here is an example of response when everithing is ok
  If you did everithing right congratulatuons! Your response must look like the
  one bellow:

  HTTP/1.1 201 Created
  {
    "data": {
      "id": "598c3c6ec54c8e0004f66519",
      "type": "user",
      "attributes": {
        "name": "John Doe",
        "email": "johndoe@enriquece.me"
      }
    }
  }

  @apiUse UserParams
  @apiUse UnauthenticatedHeader
  @apiUse JsonApiObject
  @apiUse JsonApiObjectAttributes
  @apiUse UserAttributes
  @apiUse UserObjectExemple
  @apiUse UnauthorizedError
  @apiUse UnprocessableEntity
=end
    def create
      @user = User.new(user_params)

      return render_json_api_error(@user) unless @user.save
      render_json_api(@user, status: :created, location: v1_user_path(@user))
    end

=begin
  @apiDescription As you could imagine, this end point is responsable for update
  user data. It changes data related to the user provided in authorization
  header and is totaly depending on authentication (I know that you you knew
  that but I'm here just to rememeber).
  Don't feel bad if you have no idea about how user authentication works. You
  can always go ahead and take a look at authorization section of this
  documentation. Don't be shy!

  @apiVersion 1.0.0
  @api {put} /v1/user Update user
  @apiName UpdateUser
  @apiGroup Users
  @apiPermission authenticated users only

  @apiParam {String} Id User id

  @apiExample {curl} I knew that you was waiting for it... Enjoy this example!
  In case of memory lapse, remember that this is an example and you have to
  replace the <token> key and the values in JSON as well.

  curl -i
  -X PUT
  -H 'CONTENT-TYPE: application/json'
  -H 'AUTHORIZATION: Bearer <token>'
  -d '{"name": "John Doe", "email": "johndoe@email.com", "password": "123456"}'
  https://api.enriquece.me/user

  @apiUse UserParams
  @apiUse AuthenticatedHeader
  @apiUse JsonApiObject
  @apiUse UserAttributes
  @apiUse UserObjectExemple
  @apiUse UnauthorizedError
  @apiUse UnprocessableEntity
=end
    def update
      @user.name = user_params[:name] || @user.name
      @user.password = user_params[:password] || @user.password

      return render_json_api_error(@user) unless @user.update
      render_json_api(@user)
    end

=begin
  @apiDescription Trying to remove a user? You are in the right place, despite
  the enormous sadness we feel when an account is closed. If that's what you
  want to do (please be fooled) come on! The process is simple and well
  documented. All you have to do is to send a delete request informing the user
  token in the authorization header.
  You may want to take a look at the authentication part of this documentation
  if you are not remembering what the user's token is.

  @apiVersion 1.0.0
  @api {delete} /v1/user Delete user
  @apiName DeleteUser
  @apiGroup Users
  @apiPermission authenticated users only

  @apiExample {curl} Needing that naughty example? We never ever disappoint you!
  Are you seeing the <token> key down there? It means you need to replace it
  with a valid token. Maybe you still do not know what a token is, and there's
  no problem with that. Make hot chocolate and drink while taking a look at the
  authentication section of this documentation. Cheers!

  curl -i
  -X DELETE
  -H 'CONTENT-TYPE: application/json'
  -H 'AUTHORIZATION: Bearer <token>'
  https://api.enriquece.me/user

  @apiSuccessExample 204 No content
  I'm so sorry about seeing you leave. I don't wanna talk anymore.
  No way, I was just kidding! No regrets between us. It's only an empty response
  body. This is all, hope see you latter!

  HTTP/1.1 204 No Content

  @apiUse AuthenticatedHeader
  @apiUse UnauthorizedError
=end
    def destroy
      @user.destroy
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = current_user
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.permit(:name, :email, :password)
    end
  end
end
