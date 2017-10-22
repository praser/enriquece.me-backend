# frozen_string_literal: true

module V1
  # Defines actions that involve subcategories management
  class SubcategoriesController < V1::BaseController
    before_action :set_subcategory, only: %i[update destroy]

    def create
      @subcategory = Subcategory.new(subcategory_params)

      return render_json_api_error(@subcategory) unless @subcategory.save
      props = { status: :created, location: v1_subcategory_path(@subcategory) }
      render_json_api(@subcategory, props)
    end

    def update
      updated = @subcategory.update(subcategory_params)
      return render_json_api_error(@subcategory) unless updated
      render_json_api(@subcategory)
    end

    def destroy
      @subcategory.destroy
    end

    private

    def set_subcategory
      @subcategory = Subcategory.find(params[:id])
      @subcategory = nil unless @subcategory.category.user == current_user

      return unless @subcategory.nil?
      current_user.errors.add :authorization, 'Not Authorized'
      render_json_api_error(current_user, :unauthorized)
    end

    # Only allow a trusted parameter "white list" through.
    def subcategory_params
      params.permit(:name, :category_id)
    end
  end
end
