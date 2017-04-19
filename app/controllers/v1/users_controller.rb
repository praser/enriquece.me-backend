class V1::UsersController < V1::BaseController
  before_action :set_user, only: [:show, :update, :destroy]
  skip_before_action :authenticate_request, only: [:create]

  # GET /user
  def show
    render json: @user
  end

  # POST /users
  def create
    @user = User.new(user_params)
    
    if @user.save
      render_json_api(@user, {status: :created, location: v1_user_path(@user)})
    else
      render_json_api_error(@user)
    end
  end

  # PATCH/PUT /user
  def update
    @user.name = user_params[:name] || @user.name
    @user.password = user_params[:password] || @user.password

    if @user.update
      render_json_api(@user)
    else
      render_json_api_error(@user)
    end
  end

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