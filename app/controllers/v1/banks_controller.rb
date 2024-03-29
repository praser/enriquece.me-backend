# frozen_string_literal: true

module V1
  # Defines actions that involve banks management
  class BanksController < V1::BaseController
    def index
      @banks = Bank.all

      render_json_api(@banks)
    end
  end
end
