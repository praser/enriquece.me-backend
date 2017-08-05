# frozen_string_literal: true

# Sets host to use a given subdomain.
module RequestSubdomainHelpers
  def within_subdomain(subdomain)
    before { host! "#{subdomain}.example.com" }
    after  { host! 'www.example.com' }
    yield
  end
end
