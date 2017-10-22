# frozen_string_literal: true

module V1
  # Defines actions that involve user management
  class UsersController < V1::BaseController
    before_action :set_user, only: %i[show update destroy]
    skip_before_action :authenticate_request, only: :create

    def show
      render json: @user
    end

    def create
      @user = User.new(user_params)

      return render_json_api_error(@user) unless @user.save
      render_json_api(@user, status: :created, location: v1_user_path(@user))
    end

    def update
      @user.name = user_params[:name] || @user.name
      @user.password = user_params[:password] || @user.password

      return render_json_api_error(@user) unless @user.update
      render_json_api(@user)
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
end
