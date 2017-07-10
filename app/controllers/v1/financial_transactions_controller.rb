# frozen_string_literal: true

module V1
  # Defines actions that involve financial transactions management
  class FinancialTransactionsController < V1::BaseController
    before_action :set_financial_transaction, only: %i[show update destroy]

    # # GET /v1/financial_transactions
    # def index
    #   financial_transactions = FinancialTransaction.all

    #   render json: financial_transactions
    # end

    # # GET /v1/financial_transactions/1
    # def show
    #   render json: financial_transaction
    # end

    # POST /v1/financial_transactions
    def create
      @fin_transaction = FinancialTransaction.new(financial_transaction_params)
      attach_user

      return render_json_api_error @fin_transaction unless @fin_transaction.save

      fin_trans_job(@fin_transaction) unless @fin_transaction.recurrence.nil?

      props = {
        status: :created,
        location: v1_financial_transaction_path(@fin_transaction)
      }

      render_json_api @fin_transaction, props
    end

    # # PATCH/PUT /v1/financial_transactions/1
    # def update
    #   if financial_transaction.update(financial_transaction_params)
    #     render json: financial_transaction
    #   else
    #     render(
    #        json: financial_transaction.errors,
    #        status: :unprocessable_entity
    #     )
    #   end
    # end

    # # DELETE /v1/financial_transactions/1
    # def destroy
    #   financial_transaction.destroy
    # end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_financial_transaction
      @fin_transaction = FinancialTransaction.find(params[:id])
    end

    # Attach the current_user to account
    def attach_user
      @fin_transaction.user = current_user
    end

    # Only allow a trusted parameter "white list" through.
    def financial_transaction_params
      params.permit(
        :description,
        :price,
        :date,
        :paid,
        :note,
        :account_id,
        :category_id,
        :subcategory_id,
        recurrence: %i[every on interval repeat]
      )
    end

    def fin_trans_job(fin_trans)
      RecurrentFinancialTransactionJob.perform_later(
        fin_trans.class.to_s,
        fin_trans.id.to_s
      )
    end
  end
end
