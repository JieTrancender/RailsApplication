Rails.application.routes.draw do
  get 'users/new'

  get 'users/create'

  get 'users/login'

  get 'users/verify'

  post 'users/create'

  post 'users/verify'

  root 'welcome#index'
  get 'welcome/index'

  resources :articles

  #get "login" => "users#login", :as => "login"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
