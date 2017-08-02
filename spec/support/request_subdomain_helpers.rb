# frozen_string_literal: true

# frozen_string_litral: true

module RequestSubdomainHelpers
  # Sets host to use a given subdomain.
  def within_subdomain(subdomain)
    before { host! "#{subdomain}.example.com" }
    after  { host! 'www.example.com' }
    yield
  end
end
