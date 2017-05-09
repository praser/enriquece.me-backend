class Category
  include Mongoid::Document
  field :name, type: String

  belongs_to :user

  validates :name, presence: true
  validates :name, uniqueness: {scope: :user_id, case_sensitive: false}
  validates :user_id, presence: true
end