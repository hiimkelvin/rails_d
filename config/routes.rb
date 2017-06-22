Rails.application.routes.draw do

  root 'users#new'
  get 'users/new'
  post 'users/new' => 'users#registration'
  get 'users/:id' => 'users#show'
  delete 'users/:id/destroy' => 'users#destroy'
  get 'users/:id/edit' => 'users#edit'
  patch 'users/:id/edit' => 'users#update'

  get 'sessions/new'
  post 'sessions' => "sessions#create"
  delete 'sessions/:id' => 'sessions#destroy'

  get 'secrets' => 'secrets#index'
  post 'users/:id' => 'secrets#create'
  delete 'secrets/:id' => 'secrets#destroy'

  post 'likes' => 'likes#create'
  delete 'likes/:id' => 'likes#destroy'

end
