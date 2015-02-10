Rails.application.routes.draw do
  get 'static_pages/home'

	root 'static_pages#home'
	get 'sign_up' => 'users#new'
	get 'sign_in' => 'sessions#new'
	post 'sign_in' => 'sessions#create'
	delete 'sign_out' => 'sessions#destroy'
	resources :users, only: [:index, :new, :create, :show, :update]
	resources :api_keys, only: [:create, :destroy]
end
