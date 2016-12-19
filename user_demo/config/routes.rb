Rails.application.routes.draw do
  get "signup" => "users#signup", :as => "signup"

  get "login" => "users#login", :as => "login"

  post "create_login_session" => "users#create_login_session"

  delete "logout" => "users#logout", :as => "logout"

  resources :users, only: [:create]

  get 'welcome/index'

  root 'welcome#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
