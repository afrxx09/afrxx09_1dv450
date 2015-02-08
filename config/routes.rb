Rails.application.routes.draw do
	root 'static#index'
	get 'sign_up' => 'users#new'
	get 'sign_in' => 'sessions#new'
	post 'sign_in' => 'sessions#create'
	delete 'sign_out' => 'sessions#destroy'
	post 'generate_key' => 'api_keys#generate'
	delete 'destroy_key/:user_id' => 'api_keys#destroy', as: 'destroy_key'
	resources :users, only: [:index, :new, :create, :show]
	#resources :api_keys, only: [:generate, :destroy]
end
