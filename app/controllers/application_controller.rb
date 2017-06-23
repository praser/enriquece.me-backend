# frozen_string_literal: true

# Define base rules and bahavior for controllers
class ApplicationController < ActionController::API
  before_action :authenticate_request
  attr_reader :current_user

  private

  # Authenticate requests
  def authenticate_request
    @current_user = AuthorizeApiRequest.call(request.headers).result

    return unless @current_user.nil?
    @current_user = User.new
    @current_user.errors.add :authorization, 'Not Authorized'
    render_json_api_error(@current_user, :unauthorized)
  end

  # Render error response in JSON API format
  def render_json_api_error(obj, status = :unprocessable_entity)
    render(
      json: obj,
      status: status,
      adapter: :json_api,
      serializer: ActiveModel::Serializer::ErrorSerializer
    )
  end

  # Render response in JSON API format
  def render_json_api(object, options = { status: :ok, location: nil })
    render(
      json: object,
      status: options[:status],
      location: options[:location],
      include: %i[bank account_type]
    )
  end
end
