Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get "/pages/no_excuse", to: "pages#no_excuse"

  resources :creative_excuses, only: [:show, :new, :create, :edit, :update] do
    resources :saved_excuses, only: [:new, :create]
  end
  resources :location_excuses, only: [:show, :new, :create] do
    get "/details", to: "location_excuses#details"
    resources :saved_excuses, only: [:new, :create]
  end
  resources :saved_excuses, only: [:index, :destroy]
  resources :users, only: :show
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
