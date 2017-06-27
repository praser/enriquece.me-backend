# frozen_string_literal: true

module AccountHelper
  def find_account(field = {})
    Account.find_by(field)
  end

  def create_account(data)
    FactoryGirl.create(
      :account,
      name: data['nome'],
      initial_balance: data['saldo_inicial'],
      bank: Bank.find_by(name: data['banco']),
      account_type: AccountType.find_by(name: data['tipo']),
      user: User.find_by(email: data['usuario'])
    )
  end

  def attributes_for_account(account_type, bank, params)
    json = JSON.parse(params)
    FactoryGirl.attributes_for(
      :account,
      name: json['name'],
      description: json['description'],
      initial_balance: json['initial_balance'],
      account_type_id: account_type.id.to_s,
      bank_id: bank.id.to_s
    ).to_json
  end

  def account_attribute_name_parser(attribute)
    case attribute
    when 'nome' then 'name'
    when 'descricao' then 'description'
    when 'saldo inicial' then 'initial-balance'
    else raise 'field name unknown in step definions'
    end
  end
end

World AccountHelper
