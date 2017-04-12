class V1::BanksController < V1::BaseController
  before_action :set_bank, only: [:show, :update, :destroy]

  # GET /v1/banks
  def index
    @banks = Bank.all

    render json: @banks
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bank
      @bank = Bank.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def bank_params
      params.require(:bank).permit()
    end
end
