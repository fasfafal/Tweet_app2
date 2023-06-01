Rails.application.routes.draw do
  devise_for :users
  get "login" => "users#login_form"
  post "login" => "users#login"
  post "logout" => "users#logout"
  resources :users
  
  get '/'=> 'home#top'
  resources :posts
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
