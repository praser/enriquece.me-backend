# frozen_string_literal: true

module CategoryHelper
  def find_category(field = {})
    Category.find_by(field)
  end

  def create_category(user, data)
    FactoryGirl.create(
      :category,
      name: data['nome'],
      user: user
    )
  end
end

World CategoryHelper
