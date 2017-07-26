# frozen_string_literal: true

module V1
  # Defines actions that involve financial transactions management
  class TransactionsController < V1::BaseController
    before_action :set_transaction, only: %i[show update destroy]

    # GET /v1/financial_transactions
    def index
      @transactions = Transaction.where(
        date: {
          :$gte => start_date,
          :$lte => end_date
        },
        user_id: {
          :$eq => current_user.id.to_s
        }
      )

      render_json_api @transactions
    end

    # GET /v1/financial_transactions/1
    def show
      render_json_api @transaction
    end

    # POST /v1/financial_transactions
    def create
      @transaction = Transaction.new(transaction_params)
      attach_user

      return render_json_api_error @transaction unless @transaction.save

      create_recurrences(@transaction) unless @transaction.recurrence.nil?

      props = {
        status: :created,
        location: v1_transaction_path(@transaction)
      }

      render_json_api @transaction, props
    end

    # PATCH/PUT /v1/financial_transactions/1
    def update
      old_date = @transaction.date

      unless @transaction.update(transaction_params)
        return render_json_api_error @transaction
      end

      unless transaction_params[:recurrence].nil?
        update_recurrences(
          @transaction,
          transaction_params[:recurrence],
          (@transaction.date - old_date).to_i
        )
      end

      render_json_api(@transaction)
    end

    # DELETE /v1/financial_transactions/1
    def destroy
      # TODO, Create deletion of recurrences assincronously
      @transaction.destroy
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find_by(
        id: params[:id],
        user_id: current_user.id
      )

      return unless @transaction.nil?
      current_user.errors.add :authorization, 'Not Authorized'
      render_json_api_error(current_user, :unauthorized)
    end

    # Attach the current_user to account
    def attach_user
      @transaction.user = current_user
    end

    # Only allow a trusted parameter "white list" through.
    def transaction_params
      params.permit(
        :description,
        :price,
        :date,
        :paid,
        :note,
        :account_id,
        :category_id,
        :subcategory_id,
        :recurrence,
        recurrence: %i[every on interval repeat]
      )
    end

    # Enqueue recurrences to be createad assincronously.
    def create_recurrences(fin_trans)
      CreateRecurrencesJob.perform_later(
        fin_trans.class.to_s,
        fin_trans.id.to_s
      )
    end

    # Enqueue recurrences to be updated assincronously.
    def update_recurrences(fin_trans, modifier, days_amount)
      UpdateRecurrencesJob.perform_later(
        fin_trans.class.to_s,
        fin_trans.id.to_s,
        modifier,
        days_amount
      )
    end

    # Set start date to be used in index action.
    def start_date
      return Date.parse(params[:start]) unless params[:start].nil?
      Date.today.at_beginning_of_month
    end

    # Set end date to be used in index action.
    def end_date
      return Date.parse(params[:end]) unless params[:end].nil?
      Date.today.at_end_of_month
    end
  end
end
