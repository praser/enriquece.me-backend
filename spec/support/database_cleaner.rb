RSpec.configure do |config|
	config.use_transactional_fixtures = false				
	DatabaseCleaner.strategy = :truncation

	config.around(:each) do |exemple|
		DatabaseCleaner.clean
		exemple.run
	end
end