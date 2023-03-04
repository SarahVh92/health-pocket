Rails.application.routes.draw do
  devise_for :users
  resources :users, only: %i[show update]
  get "/users/:id/:form_name", to: "users#show"
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :documents, only: %i[index edit update new create show]
  resources :immunizations, only: %i[index show]
  resources :appointments, only: %i[index new create]
end
