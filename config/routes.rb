PostitTemplate::Application.routes.draw do
  root to: 'posts#index'

  resources 'posts', except: [:destroy] do
    resources 'comments', only: [:create]
    post 'categories/add', to: 'categories#add_category'
  end

  resources 'categories', only: [:new, :create, :show]

  get '/register', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  resources :users, only: [:create]
end
