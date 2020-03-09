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
  end

  root to: 'users#top'

  resources :users do
    member do
      get :following, :followers
    end
  end

  get 'events/confirm', to: 'events#confirm'
  resources :events do
    resources :join_users, only: [:create, :destroy]
    resources :likes, only: [:create, :destroy]
    resource :comments, only: [:create, :destroy]
  end
  resources :users
  resources :relationships, only: [:create, :destroy]
end

