# frozen_string_literal: true

module V1
  # Defines actions that involve categories management
  class CategoriesController < V1::BaseController
    before_action :set_category, only: %i[show update destroy]

    # GET /v1/categories
    def index
      @categories = Category.where(user_id: current_user.id)

      render_json_api(@categories)
    end

    # POST /v1/categories
    def create
      @category = Category.new(category_params)
      attach_user

      return render_json_api_error(@category) unless @category.save

      props = { status: :created, location: v1_category_path(@category) }
      render_json_api(@category, props)
    end

    # PATCH/PUT /v1/categories/1
    def update
      updated = @category.update(category_params)
      return render_json_api_error(@category) unless updated

      render_json_api(@category)
    end

    # DELETE /v1/categories/1
    def destroy
      @category.destroy
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find_by(id: params[:id], user_id: current_user.id)

      return unless @category.nil?
      current_user.errors.add :authorization, 'Not Authorized'
      render_json_api_error(current_user, :unauthorized)
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
end
