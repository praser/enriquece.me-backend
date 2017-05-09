require 'rails_helper'

RSpec.describe Category, type: :model do
	it {is_expected.to respond_to :name}
	it {is_expected.to validate_presence_of :name}
	it {is_expected.to validate_uniqueness_of(:name).scoped_to(:user_id)}
	
	it {is_expected.to belong_to :user}
	it {is_expected.to validate_presence_of :user_id}
	it {is_expected.to have_many(:subcategories)}
end
