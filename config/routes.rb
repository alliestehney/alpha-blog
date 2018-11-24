Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'page#home'
  get '/about', to: 'page#about'

  # creates all the things for articles
  resources :articles

  get 'signup', to: 'users#new'

  resources :users, except: [:new]
end
