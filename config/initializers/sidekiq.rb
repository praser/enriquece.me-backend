# frozen_string_literal: true

require 'sidekiq'
require 'sidekiq/web'

# TODO: Add real authentication to access sidekiq panel
# Sidekiq::Web.use(Rack::Auth::Basic) do |user, password|
#   %w[enriqueceme 3nr1qu3cem3] == [user, password]
# end

Sidekiq.configure_client do |config|
  config.redis = { size: 2 }
end

Sidekiq.configure_server do |config|
  # The config.redis is calculated by the
  # concurrency value so you do not need to
  # specify this. For this demo I do
  # show it to understand the numbers
  config.redis = { size: 8 }
end
