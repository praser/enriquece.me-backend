Rails.application.routes.draw do

	api_version(module: "v1", subdomain: "api", path: {value: "v1"}, defaults: {format: "json"}, default: true) do
    	post 'authenticate', to: 'authentications#create'
    	resources :users
	end
end
