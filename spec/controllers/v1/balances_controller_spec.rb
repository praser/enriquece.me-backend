# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::BalancesController, type: :controller do
  before(:each) do
    allow(controller).to receive(:authenticate_request).and_return(user)
    allow(controller).to receive(:current_user).and_return(user)

    FactoryGirl.create_list(
      :transaction,
      10,
      user: user,
      account: accounts.sample
    )
  end

  let(:user) { FactoryGirl.create(:user) }
  let(:accounts) { FactoryGirl.create_list(:account, 3) }

  describe 'GET #index' do
    it 'calculates previous balance' do
      balance = calculate_balance(
        date: { '$lt': Time.current.beginning_of_month }
      )
      get :index
      expect(assigns(:previous_balance)).to eq(balance)
    end

    it 'calculates period balance' do
      balance = calculate_balance(
        date: {
          '$gte': Time.current.beginning_of_month,
          '$lte': Time.current.end_of_month
        }
      )

      get :index
      expect(assigns(:period_balance)).to eq(balance)
    end

    it 'calculates balance for each day' do
      daily_balance = {}
      days = Transaction.where(
        date: {
          '$gte': Time.current.beginning_of_month,
          '$lte': Time.current.end_of_month
        }
      ).distinct(:date).sort

      days.each do |day|
        daily_balance[day.to_date.to_s] = calculate_balance(
          date: { '$eq': day }
        )
      end

      get :index
      expect(assigns(:daily_balance)).to eq(daily_balance)
    end

    def calculate_balance(criteria)
      criteria[:user] = user
      paid = 0
      unpaid = 0

      Transaction.where(
        criteria
      ).each { |item| item[:paid] ? paid += item.price : unpaid += item.price }

      { paid: paid.round(2), unpaid: unpaid.round(2) }
    end
  end
end
