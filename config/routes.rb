Rails.application.routes.draw do

  root 'welcome#index'
  get 'logout', to: 'sessions#destroy'

  get '/auth/uber', as: :login
  get "/auth/uber/callback", to: "sessions#create"

  get 'dashboard', to: 'users#show'

  resources :ride_estimates, only: [:create, :index]
end
