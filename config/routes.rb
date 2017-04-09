Rails.application.routes.draw do

	api_version(module: "v1", path: {value: "v1"}, defaults: {format: "json"}, default: true) do
    	post 'authenticate', to: 'authentications#create'
    	resources :users
	end
end
