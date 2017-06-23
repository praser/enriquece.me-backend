# frozen_string_literal: true

# User serializer
class UserSerializer < ActiveModel::Serializer
  type :user
  attributes :id, :name, :email
end
