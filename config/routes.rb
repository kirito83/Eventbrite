Rails.application.routes.draw do
	root 'static_pages#home'
	resources :users
	resources :events do
    post 'suscribe', on: :member
    post 'unsuscribe', on: :member
    post 'invite', on: :member
  end

  	#users
  	get '/signup',  to:'users#new'
  	post '/signup',	to:'users#create'

  	#Sessions
  	get    '/login',  to: 'sessions#new'
  	post   '/login',  to: 'sessions#create'
  	delete '/logout', to: 'sessions#destroy'
  end
