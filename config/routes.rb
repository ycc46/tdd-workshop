Rails.application.routes.draw do
  devise_for :users
  namespace :api, defult: { format: :json } do
    scope module: :v1 do

    end
  end

  root 'home#index'
  resources :articles
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
