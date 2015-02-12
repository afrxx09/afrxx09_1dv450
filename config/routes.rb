Rails.application.routes.draw do
	namespace :api, defaults: {format: 'json'} do
		namespace :v1 do
			resources :users
		end
		#namespace :v2 do
		#	resources :asd
		#end
	end
	root 'static_pages#home'
	get 'sign_up' => 'users#new'
	get 'sign_in' => 'sessions#new'
	post 'sign_in' => 'sessions#create'
	delete 'sign_out' => 'sessions#destroy'
	resources :users, only: [:index, :new, :create, :show, :update]
	resources :api_keys, only: [:create, :destroy]
end
