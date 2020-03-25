# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users#, controllers: {
    # registrations: 'users/registrations',
  #   sessions: 'users/sessions',
  #   passwords: 'users/passwords'
  # }

  devise_for :admin#, controllers: {
  #   registrations: 'admin/registrations',
  #   sessions: 'admin/sessions'
  # }
  namespace :admin do
    resources :users
    resources :events, only: %i[index destroy]
  end

  root to: 'users#top'
  get 'users/about', to: 'users#about'
  get 'events/search', to: 'events#search_index'
  get 'events/pickup', to: 'events#pickup'

  resources :users do
    member do
      get :following, :followers
    end
  end

  resources :notifications do
    collection do
      patch :read
    end
  end

  post 'events/confirm', to: 'events#confirm'
  post '/events/:event_id/likes' => 'likes#create'
  delete '/events/:event_id/likes' => 'likes#destroy'
  post '/events/:event_id/join_users' => 'join_users#create'
  delete '/events/:event_id/join_users' => 'join_users#destroy'
  resources :events do
    resource :comments, only: %i[create destroy]
  end
  resources :relationships, only: %i[create destroy]
end
