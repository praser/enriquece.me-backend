class AccountType
  include Mongoid::Document
  field :name, type: String

  has_many :accounts

  validates :name, presence: true, uniqueness: true
end
