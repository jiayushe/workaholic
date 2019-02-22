Rails.application.routes.draw do
  root 'welcome#index'
  
  resources :items do
    resources :remarks
    member do
      get 'complete'
    end
  end

  resources :categories

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  resources :users

  get "/admin", to: "users#admin"
end
