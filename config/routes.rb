Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :creative_excuses, only: [:show, :new, :create, :edit, :update]
  resources :location_excuses, only: [:show, :new, :create]
  resources :saved_excuses, except: [:index, :new, :create, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
