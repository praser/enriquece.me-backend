# frozen_string_literal: true

module FinancialTransactionHelper
  def attributes_for_financial_transaction(subcategory, category, account, params)
    json = JSON.parse(params)
    FactoryGirl.attributes_for(
      :financial_transaction,
      description: json['description'],
      price: json['price'],
      note: json['note'],
      recurrence: json['recurrence'],
      subcategory_id: subcategory.nil? ? nil : subcategory.id.to_s,
      category_id: category.id.to_s,
      account_id: account.id.to_s
    ).to_json
  end
end

World FinancialTransactionHelper
