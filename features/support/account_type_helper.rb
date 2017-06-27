# frozen_string_literal: true

module AccountTypeHelper
  def find_account_type(field = {})
    AccountType.find_by(field)
  end
end

World AccountTypeHelper
