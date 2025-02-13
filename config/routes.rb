Rails.application.routes.draw do
  root "posts#index"
  
  devise_for :users
  
  resources :posts do
    member do
      get :next_post
    end
  end
  
  resources :users, only: [:show] do
    member do
      get :settings
      patch :update_settings
    end
  end
end
