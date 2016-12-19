Rails.application.routes.draw do
  get 'sessions/new'

  get 'sessions/create'

  get 'applicants/new'

  get 'applicants/create'

  post 'applicants/create'

  post 'sessions/create'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
