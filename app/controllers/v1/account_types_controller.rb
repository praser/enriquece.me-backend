# frozen_string_literal: true

module V1
  # Defines actions that involve managing account types
  class AccountTypesController < V1::BaseController
    # GET /v1/account_types
    def index
      @account_types = AccountType.all

      render_json_api(@account_types)
    end

    private

    # Only allow a trusted parameter "white list" through.
    def account_type_params
      params.permit
    end
  end
end
