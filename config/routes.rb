Rails.application.routes.draw do
	namespace :api, defaults: {format: 'json'} do
		namespace :v1 do
			resources :users
		end
	end
	root 'static_pages#home'
	get 'sign_up' => 'api_users#new'
	get 'sign_in' => 'sessions#new'
	post 'sign_in' => 'sessions#create'
	delete 'sign_out' => 'sessions#destroy'
	resources :api_users, only: [:index, :new, :create, :show, :update] do
		resources :api_applications, only: [:new, :create, :update, :show] do
			resources :api_keys, only: [:create, :update]
		end
	end
end
