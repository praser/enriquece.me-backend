# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  api_version(
    module: 'v1',
    path: { value: 'v1' },
    defaults: { format: 'json' },
    default: true
  ) do
    post 'authenticate', to: 'authentications#create'

    post '/users', to: 'users#create'
    get '/user', to: 'users#show'
    put '/user', to: 'users#update'
    patch '/user', to: 'users#update'
    delete '/user', to: 'users#destroy'

    get '/banks', to: 'banks#index'

    get '/account_types', to: 'account_types#index'

    get(
      '/transactions/since/:start',
      to: 'transactions#index',
      as: :transactions_since
    )

    get(
      '/transactions/since/:start/until/:end',
      to: 'transactions#index',
      as: :transactions_since_until
    )

    delete(
      '/transactions/:id/:recurrence',
      to: 'transactions#destroy'
    )

    # resources without new and edit routes
    with_options(except: %i[new edit]) do |opt|
      opt.resources :accounts
      opt.resources :categories
      opt.resources :transactions
    end

    # resources without new, edit and index routes
    with_options(except: %i[new edit index]) do |opt|
      opt.resources :subcategories
    end
  end
end
