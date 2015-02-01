Rails.application.routes.draw do
	root 'users#signin'
	get 'signup' => 'users#new'
	resources :users
end
