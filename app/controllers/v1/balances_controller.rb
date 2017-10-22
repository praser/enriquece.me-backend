# frozen_string_literal: true

module V1
  # Define actions that involves balance management
  class BalancesController < V1::BaseController
    include DateIntervalParams

    def index
      previous_criteria = search_params[:previous_criteria]
      period_criteria = search_params[:period_criteria]
      daily_group = search_params[:daily_group]

      @previous_balance = find(false, previous_criteria)
      @period_balance = find(false, period_criteria)
      @daily_balance = find(true, period_criteria, daily_group)

      balance = Balance.new(
        previous_balance: @previous_balance,
        period_balance: @period_balance,
        daily_balance: @daily_balance
      )

      render_json_api(balance)
    end

    private

    def search_params
      search = {
        previous_criteria: { date: { '$lt': start_date } },
        period_criteria: {
          date: {
            '$gte': start_date,
            '$lte': end_date
          }
        },
        daily_group: {
          _id: { date: '$date', paid: '$paid' },
          balance: { '$sum': '$price' }
        }
      }

      searh_account(search)
    end

    def searh_account(search)
      unless params[:account].nil?
        search[:previous_criteria][:account_id] = { '$eq': params[:account] }
        search[:period_criteria][:account_id] = { '$eq': params[:account] }
      end

      search
    end

    def find(daily, criteria, group = nil)
      return parse_by_date(aggregate(criteria, group)) if daily
      parse_by_payment(aggregate(criteria, group))
    end

    def aggregate(criteria, group = nil)
      criteria[:user] = current_user
      if group.nil?
        group = { _id: { paid: '$paid' }, balance: { '$sum': '$price' } }
      end

      transactions = Transaction.where(
        criteria
      ).group(
        group
      ).asc(_id: 1)

      Transaction.collection.aggregate(transactions.pipeline)
    end

    def parse_by_payment(aggregation)
      paid = 0
      unpaid = 0

      aggregation.each do |item|
        item[:_id][:paid] ? paid = item[:balance] : unpaid = item[:balance]
      end

      {
        paid: paid.round(2),
        unpaid: unpaid.round(2)
      }
    end

    def parse_by_date(aggregation)
      daily = {}
      aggregation.to_a.sort_by { |item| item[:_id][:date] }.each do |item|
        date_str = Time.zone.parse(item[:_id][:date].to_s).to_date.to_s
        daily[date_str] = { paid: 0, unpaid: 0 } unless daily.key? date_str

        separate_paid_unpaid(item, daily, date_str)
      end

      daily
    end

    def separate_paid_unpaid(item, daily, date_str)
      if item[:_id][:paid]
        daily[date_str][:paid] = item[:balance].round(2)
      else
        daily[date_str][:unpaid] = item[:balance].round(2)
      end
    end
  end
end
