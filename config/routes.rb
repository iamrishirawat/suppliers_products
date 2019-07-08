Rails.application.routes.draw do

  root 'suppliers#index'

  resources :mappings, only: [:create]

  resources :suppliers, only: [:index, :show]

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
