Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users do
  	resources :posts
  end

  resources :sessions, only: [:new, :create, :destroy]
  get '/signin',		to: 'sessions#new'
  delete '/signout',	to: 'sessions#destroy'
  get '/signup',		to: 'users#new'

  root to: 'static_pages#home'

end
