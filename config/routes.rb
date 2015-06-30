PostitTemplate::Application.routes.draw do
  root to: 'posts#index'

  resources 'posts', except: [:destroy] do
    post 'vote', on:  :member
    resources 'comments', only: [:create] do
      post 'vote', on:  :member
    end
  end
  get '/register', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'


  resources 'users', only: [:create, :show, :edit, :update]
  resources 'categories', only: [:new, :create, :show]
end
