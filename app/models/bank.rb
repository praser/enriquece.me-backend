class Bank
  include Mongoid::Document

  field :name, type: String
  field :code, type: Integer

  has_many :accounts

  validates :name, presence: true, uniqueness: true
  validates :code, presence: true, uniqueness: true, numericality: true, length: {in: 1..4}
end
