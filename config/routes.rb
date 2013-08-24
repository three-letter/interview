Interview::Application.routes.draw do


	resources :users
	resources :apis

	match "/signup", :to => "users#new"
	match "/login", :to => "sessions#new"
	match "/signin", :to => "sessions#create"
	match "/logout", :to => "sessions#destroy"

	root :to => "users#index"

end
