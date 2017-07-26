# frozen_string_literal: true

module TransactionHelper
  def attributes_for_transaction(subcategory, category, account, params)
    json = JSON.parse(params)
    FactoryGirl.attributes_for(
      :transaction,
      description: json['description'],
      price: json['price'],
      date: json['date'],
      paid: json['paid'],
      note: json['note'],
      recurrence: json['recurrence'],
      subcategory_id: subcategory.nil? ? nil : subcategory.id.to_s,
      category_id: category.id.to_s,
      account_id: account.id.to_s
    ).to_json
  end

  def create_transaction(data)
    Transaction.create(
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

  def find_transaction(field = {})
    Transaction.find_by(field)
  end

  def find_transaction_where(*args)
    Transaction.where(*args).to_a
  end

  def response_transaction
    JSON.parse(last_response.body)['data'].map do |item|
      Transaction.find_by(id: item['id'])
    end
  end
end

World TransactionHelper
