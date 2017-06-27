# frozen_string_literal: true

module BankHelper
  def find_bank(field = {})
    Bank.find_by(field)
  end
end

World BankHelper
