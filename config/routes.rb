Rails.application.routes.draw do

  root 'welcome#index'

  get '/auth/uber', as: :login
  get "/auth/uber/callback", to: "sessions#create"

  get 'dashboard', to: 'user#show'
end
