Rails.application.routes.draw do
  root "static_pages#home"
  devise_for :users, controllers: {
    sessions: "users/sessions",
    omniauth_callbacks: "users/omniauth_callbacks"
  }
  resources :songs
  resources :singers
  resources :users do
    resources :likeds, only: :index, controller: "users/likeds"
  end
  resources :comments, only: %i(create destroy)
  resources :likeds, only: %i(create destroy)
end
