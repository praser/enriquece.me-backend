Rails.application.routes.draw do

	api_version(module: "v1", path: {value: "v1"}, defaults: {format: "json"}, default: true) do
    	post 'authenticate', to: 'authentications#create'
    	
        post 'users', to: 'users#create'
    	get 'user', to: 'users#show'
    	put 'user', to: 'users#update'
    	patch 'user', to: 'users#update'
    	delete 'user', to: 'users#destroy'
	end
end
