Rails.application.routes.draw do
  resources :users
  resources :beers
  resources :breweries
  resource :session, only: [:new, :create, :destroy]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "breweries#index"
  # Same as `get '/', to: 'breweries#index'`

  # get "kaikki_bisset", to: "beers#index"
  # get "ratings", to: "ratings#index"
  # get "ratings/new", to: "ratings#new"
  # post "ratings", to: "ratings#create"
  resources :ratings, only: [:index, :new, :create, :destroy]
  get "signup", to: "users#new"
  get "signin", to: "sessions#new"
  delete "signout", to: "sessions#destroy"
  resources :memberships, only: [:new, :create, :destroy]
  resources :beer_clubs, :path => '/beerclubs'
end
