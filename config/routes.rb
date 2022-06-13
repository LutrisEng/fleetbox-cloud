# frozen_string_literal: true

Rails.application.routes.draw do
  resources :log_items
  resources :tire_sets
  resources :vehicles

  root 'vehicles#index'

  get '/login' => 'auth0#login'
  get '/auth/auth0/callback' => 'auth0#callback'
  post '/auth/developer/callback' => 'auth0#developer_callback'
  get '/auth/failure' => 'auth0#failure'
  get '/logout' => 'auth0#logout'
end
