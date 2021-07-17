Rails.application.routes.draw do
  resources :chats
  post '/chats/new', to: 'chats#new'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'home#index'
  #mount ActionCable .server => '/cable'
end
