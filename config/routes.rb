Rails.application.routes.draw do
  root "static_pages#home"
  devise_for :users, controllers: {
    sessions: "users/sessions",
    omniauth_callbacks: "users/omniauth_callbacks"
  }
  resources :songs do
    get "buy", on: :member
  end
  resources :singers
  resources :users do
    resources :likeds, only: :index, controller: "users/likeds"
    resources :buyeds, only: :index, controller: "users/buyeds"
  end
  resources :comments, only: %i(create destroy)
  resources :likeds, only: %i(create destroy)
  scope path: :managers, as: :managers do
    get "token", to: "managers#token"
    get "edit", to: "managers#edit"
    post "update", to: "managers#update"
  end
end
