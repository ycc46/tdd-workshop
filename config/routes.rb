Rails.application.routes.draw do
  devise_for :users
  namespace :api, defaults: { format: :json } do
    scope module: :v1 do
      resources :users, only: [:show, :create, :update, :destroy] do
        resources :orders, only: [:index, :show, :create]
      end
      resources :sessions, only: [:create, :destroy]
      resources :toys, only: [:show, :create, :update, :destroy, :index]

    end
  end

  root 'home#index'
  resources :articles
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
