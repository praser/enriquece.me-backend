class V1::CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :update, :destroy]

  # GET /v1/categories
  def index
    @categories = Category.find_by(user_id: current_user.id)

    render json: @v1_categories
  end

  # GET /v1/categories/1
  def show
    render json: @v1_category
  end

  # POST /v1/categories
  def create
    @category = Category.new(category_params)
    attach_user

    if @category.save
      render_json_api(@category, {status: :created, location: v1_category_path(@category)})
    else
      render_json_api_error(@category)
    end
  end

  # PATCH/PUT /v1/categories/1
  def update
    if @category.update(category_params)
      render_json_api(@category)
    else
      render_json_api_error(@category)
    end
  end

  # DELETE /v1/categories/1
  def destroy
    @v1_category.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find_by(id: params[:id], user_id: current_user.id)

      if @category.nil?
        current_user.errors.add :authorization, 'Not Authorized'
        render_json_api_error(current_user, :unauthorized)
      end
    end

    # Only allow a trusted parameter "white list" through.
    def category_params
      params.permit(:name)
    end

    # Attach the current_user to category
    def attach_user
       @category.user = current_user   
    end
end
