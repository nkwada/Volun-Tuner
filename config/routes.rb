Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    passwords: 'users/passwords'
  }

  devise_for :admin, controllers: {
    registrations: 'admin/registrations',
    sessions: 'admin/sessions'
  }
  namespace :admin do
    resources :users
    resources :events, only: [:index, :destroy]
  end

  root to: 'users#top'

  resources :users do
    member do
      get :following, :followers
    end
  end


  post 'events/confirm', to: 'events#confirm'
  get 'events/search', to: 'events#search_index'
  get 'events/search_location', to: 'events#search_location'
  resources :events do
    resources :join_users, only: [:create, :destroy]
    resources :likes, only: [:create, :destroy]
    resource :comments, only: [:create, :destroy]
  end

  resources :relationships, only: [:create, :destroy]
end

