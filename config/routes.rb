require 'api_constraints'

MarketPlaceApi::Application.routes.draw do
  mount SabisuRails::Engine => "/sabisu_rails"
  devise_for :users
  # Api definition
  #for better understanding of this => http://stackoverflow.com/questions/9627546/api-versioning-for-rails-routes
  namespace :api, defaults: { format: :json },
                              constraints: { subdomain: 'api' }, path: '/'  do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
          # We are going to list our resources here
          resources :users, :only => [:show, :create, :update, :destroy]
    end
  end
end