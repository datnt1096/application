Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: "users/sessions"
  }
  root "static_pages#home"
  resources :songs
  resources :singers
  resources :playlists
  resources :playlist_songs
  resources :users
  resources :singers
  resources :comments, only: %i(create destroy)
  resources :genres
  namespace :admin do
    resources :songs, except: %i(index show)
    resources :comments, except: %i(index show)
  end
  resources :likeds
end
