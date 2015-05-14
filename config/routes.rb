PostitTemplate::Application.routes.draw do
  root to: 'posts#index'

  # get '/posts', to: 'posts#index' 
  # get '/posts/:id', to: 'posts#show'
  # get '/posts/new', to: 'posts#new'
  # get '/posts/:id/edit' to: 'posts#edit'
  # post '/posts' to: 'posts#create'
  # patch '/posts/:id', to: 'posts#update'

  resources 'posts', except: [:destroy] do
    resources 'comments', only: [:create]
    post 'categories/add', to: 'categories#add_category'
  end

  resources 'categories', only: [:new, :create, :show]
end
