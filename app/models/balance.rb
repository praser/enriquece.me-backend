# frozen_string_literal: true

# Balance Model
class Balance < ActiveModelSerializers::Model
  attributes :previous_balance, :period_balance, :daily_balance
end
