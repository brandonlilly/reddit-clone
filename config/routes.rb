Rails.application.routes.draw do
  root to: 'sessions#new'
  resources :users
  resource :session
  resources :subs
  resources :posts do
    member do
      resources :comments, only: [:new]
    end
  end
  resources :comments, except: [:new]
end
