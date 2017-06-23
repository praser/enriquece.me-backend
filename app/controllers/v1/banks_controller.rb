# frozen_string_literal: true

module V1
  # Defines actions that involve banks management
  class BanksController < V1::BaseController
    # GET /v1/banks
    def index
      @banks = Bank.all

      render_json_api(@banks)
    end

    private

    # Only allow a trusted parameter "white list" through.
    def bank_params
      params.require(:bank).permit
    end
  end
end
