class User
	include Mongoid::Document
	include ActiveModel::SecurePassword

	field :name, type: String
	field :email, type: String
	field :password_digest, type: String

	has_secure_password validations: false

	validates :name, presence: true

	validates :email, presence: true
	validates :email, uniqueness: true
	validates :email, format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, message: 'Email seems to be invalid'}

	validates :password, presence: true, on: :create
	validates :password, length: { in: 6..20 }, allow_blank: true

end
