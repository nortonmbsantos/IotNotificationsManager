require 'api_version_constraint'

Rails.application.routes.draw do

  root to: 'application#index'

  # devise_for :users
  namespace :api, defaults: {format: :json}, path: '/' do
    namespace :v1, path: '/' do
      resources :users, only: [:show, :create, :update, :destroy]
      resources :devices, only: [:show, :create, :update, :destroy]
      resources :notifications, only: [:show, :create, :update]
      resources :groups, only: [:show, :create, :update, :destroy]
    end
  end

end