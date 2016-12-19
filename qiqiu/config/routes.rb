Rails.application.routes.draw do
  get 'uploads/index'

  get 'uploads/index' => 'uploads#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
