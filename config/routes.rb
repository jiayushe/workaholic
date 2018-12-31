Rails.application.routes.draw do
  get 'welcome/index'
  
  resources :items do
    resources :remarks
  end

  root 'welcome#index'
end
