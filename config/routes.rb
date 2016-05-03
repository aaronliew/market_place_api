require 'api_constraints'

MarketPlaceApi::Application.routes.draw do
  #mount SabisuRails::Engine => "/sabisu_rails"
  devise_for :users
  # Api definition
  #for better understanding of this => http://stackoverflow.com/questions/9627546/api-versioning-for-rails-routes
  namespace :api, defaults: { format: :json },
                              constraints: { subdomain: 'api' }, path: '/'  do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
    # We are going to list our resources here
      resources :users, :only => [:index, :show, :create, :update, :destroy] do
        # this is the line
          resources :products, :only => [:index, :create, :show, :update, :destroy]
          resources :orders, :only => [:index, :show, :create]
      end
      resources :sessions, :only => [:create, :destroy]
      resources :products, :only => [:index, :show, :index]

    end
  end
end