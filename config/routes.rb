Rails.application.routes.draw do

  root 'welcome#index'
  get 'logout', to: 'sessions#destroy'

  get '/auth/uber', as: :login
  get "/auth/uber/callback", to: "sessions#create"

  get 'dashboard', to: 'users#show'

  resources :user_trips, only: [:create, :index]
  resources :ride_estimates, only: [:create, :index]

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :estimates, only: [:index]
      resources :user_trips, only: [:create]
    end
  end
end
