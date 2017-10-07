# frozen_string_literal: true

# Account model
class Account
  include Mongoid::Document
  include Mongoid::Timestamps

  after_create :create_initial_transaction
  after_update :update_initial_transaction
  before_destroy :delete_initial_transaction

  field :name, type: String
  field :description, type: String
  field :initial_balance, type: Float

  belongs_to :bank
  belongs_to :account_type
  belongs_to :user
  has_many :transactions
  belongs_to(
    :initial_transaction,
    class_name: 'Transaction',
    foreign_key: :initial_transaction_id,
    optional: true,
    autosave: true
  )

  validates :name, presence: true, length: { maximum: 100 }
  validates :description, length: { maximum: 500 }
  validates :initial_balance, presence: true, numericality: true
  validates :bank_id, presence: true
  validates :account_type_id, presence: true
  validates :user_id, presence: true

  private 

  def create_initial_transaction
    # The inital_transaction is created through Model.collection.insert_one to
    # skip validation because the initial balance does not have a category
    Transaction.collection.insert_one(
      description: 'Initial Balance',
      price: self.initial_balance,
      paid: true,
      date: Date.parse('1900-01-01'),
      account_id: self.id,
      user_id: self.user.id
    )

    self.initial_transaction = Transaction.find_by(account_id: self.id)
    self.save
  end

  def update_initial_transaction
    # The inital_transaction is updated through Model.collection.update_one to
    # skip validation because the initial balance does not have a category
    Transaction.collection.update_one(
      { "_id": BSON::ObjectId("59d8c4133c21e5ab3bfe8518") },
      { "$set": { price: 300 } })
  end

  def delete_initial_transaction
    self.initial_transaction.delete
  end
end
