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

  def create_financial_transaction(data)
    FinancialTransaction.create(
      description: data['descricao'],
      price: data['preco'],
      date: Date.parse(data['data']),
      paid: data['pago'],
      subcategory: find_subcategory(name: data['subcategoria']),
      category: find_category(name: data['categoria']),
      account: find_account(name: data['conta']),
      user: find_user(email: data['usuario'])
    )
  end

  def find_financial_transaction(field = {})
    FinancialTransaction.find_by(field)
  end
end

World FinancialTransactionHelper
