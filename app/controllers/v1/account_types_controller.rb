class V1::AccountTypesController < V1::BaseController
  before_action :set_account_type, only: [:show, :update, :destroy]

  # GET /v1/account_types
  def index
    @account_types = AccountType.all

    render json: @account_types
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account_type
      @account_type = V1::AccountType.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def account_type_params
      params.permit()
    end
end
