Rails.application.routes.draw do
	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	# TODO: Before create any route, see versionist documentation in https://github.com/bploetz/versionist in order to create versioned routos of the API.
	api_version(:module => "v1", :path => {:value => "v1"}, :defaults => {:format => "json"}, :default => true) do
	end
end
