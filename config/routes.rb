Rails.application.routes.draw do
  root 'welcome#index'
  
  resources :items do
    resources :remarks
  end

  resources :categories

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  resources :users
end
