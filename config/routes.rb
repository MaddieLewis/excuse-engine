Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: 'pages#home'
  get "/pages/no_excuse", to: "pages#no_excuse"

  resources :creative_excuses do
    resources :saved_excuses, only: [:new, :create]
  end
  resources :location_excuses, only: [:show, :new, :create] do
    get "/details", to: "location_excuses#details"
    get "/gmaps", to: "location_excuses#gmaps"
    resources :saved_excuses, only: [:new, :create]
  end
  resources :saved_excuses, only: [:index, :destroy]
  resources :users, only: :show

  resources :reported_excuses do
    resources :saved_excuses, only: [:new, :create]
    put :upvote, to: "reported_excuses#upvote"
    put :downvote, to: "reported_excuses#downvote"
  end
end
