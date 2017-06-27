# frozen_string_literal: true

module RequestHelper
  def request(method, path, params = nil, token = nil)
    header_filler token

    case method.downcase
    when :get then get path
    when :post then post path, params
    when :put then put path, params
    when :patch then patch path, params
    when :delete then delete path
    else raise 'HTTP method unknown is step definitions'
    end
  end

  private

  def header_filler(token = nil)
    header 'Content-Type', 'application/vnd.api+json'
    header 'Authorization', "Bearer #{token}" if token
  end
end

World RequestHelper
