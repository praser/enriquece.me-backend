# frozen_string_literal: true

module V1
  # Defines actions that involve managing account types
  class AccountTypesController < V1::BaseController
    def index
      @account_types = AccountType.all

      render_json_api(@account_types)
    end
  end
end
