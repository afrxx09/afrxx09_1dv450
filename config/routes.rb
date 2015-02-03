Rails.application.routes.draw do
	root 'sessions#new'
	get 'sign_up' => 'users#new'
	get 'sign_in' => 'sessions#new'
	post 'sign_in' => 'sessions#create'
	delete 'sign_out' => 'sessions#destroy'
	resources :users
end
