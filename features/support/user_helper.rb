# frozen_string_literal: true

module UserHelper
  def find_user(field = {})
    User.find_by(field)
  end

  def create_user(data)
    FactoryGirl.create(
      :user,
      name: data['nome'],
      email: data['email'],
      password: data['senha']
    )
  end
end

World UserHelper
