# frozen_string_literal: true

module V1
  # Defines actions that involve financial transactions management
  class TransactionsController < V1::BaseController
    include DateIntervalParams
    before_action :set_transaction, only: %i[show update destroy]

    def index
      @transactions = Transaction.where(
        date: { :$gte => start_date, :$lte => end_date },
        user_id: { :$eq => current_user.id.to_s }
      )

      render_json_api @transactions
    end

    def show
      render_json_api @transaction
    end

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

    def destroy
      recurrence = @transaction.recurrence
      date = @transaction.date
      modifier = transaction_params[:recurrence]

      @transaction.destroy
      delete_recurrences(recurrence, modifier, date) unless modifier.nil?
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
        :destination_account_id,
        :category_id,
        :subcategory_id,
        :recurrence,
        recurrence: %i[every on interval repeat]
      )
    end

    # Enqueue recurrences to be createad asynchronously.
    def create_recurrences(transaction)
      CreateRecurrencesJob.perform_later(
        transaction.class.to_s,
        transaction.id.to_s
      )
    end

    # Enqueue recurrences to be updated asynchronously.
    def update_recurrences(transaction, modifier, days_amount)
      UpdateRecurrencesJob.perform_later(
        transaction.class.to_s,
        transaction.id.to_s,
        modifier,
        days_amount
      )
    end

    # Enqueue recurrences to be deleted asynchronously
    def delete_recurrences(recurrence, modifier, date = nil)
      DeleteRecurrencesJob.perform_later(
        recurrence.class.to_s,
        recurrence.id.to_s,
        modifier,
        date
      )
    end
  end
end
