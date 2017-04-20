class V1::CategoriesController < ApplicationController
  before_action :set_v1_category, only: [:show, :update, :destroy]

  # GET /v1/categories
  def index
    @v1_categories = V1::Category.all

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
    if @v1_category.update(v1_category_params)
      render json: @v1_category
    else
      render json: @v1_category.errors, status: :unprocessable_entity
    end
  end

  # DELETE /v1/categories/1
  def destroy
    @v1_category.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_v1_category
      @v1_category = V1::Category.find(params[:id])
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
