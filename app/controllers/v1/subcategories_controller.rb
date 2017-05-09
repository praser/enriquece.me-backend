class V1::SubcategoriesController < V1::BaseController
  before_action :set_subcategory, only: [:show, :update, :destroy]

  # GET /v1/subcategories
  def index
    @v1_subcategories = Subcategory.all

    render json: @v1_subcategories
  end

  # GET /v1/subcategories/1
  def show
    render json: @subcategory
  end

  # POST /v1/subcategories
  def create
    @subcategory = Subcategory.new(subcategory_params)

    if @subcategory.save
      render_json_api(@subcategory, {status: :created, location: v1_subcategory_path(@subcategory)})
    else
      render_json_api_error(@subcategory)
    end
  end

  # PATCH/PUT /v1/subcategories/1
  def update
    if @subcategory.update(subcategory_params)
      render json: @subcategory
    else
      render json: @subcategory.errors, status: :unprocessable_entity
    end
  end

  # DELETE /v1/subcategories/1
  def destroy
    @subcategory.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subcategory
      @subcategory = Subcategory.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def subcategory_params
      params.permit(:name, :category_id)
    end
end
