Rails.application.routes.draw do
	namespace :api, defaults: {format: 'json'} do
		namespace :v1 do
			resources :users
			resources :places
			resources :events
			resources :tags
		end
	end
	root 'static_pages#home'
	get 'sign_up' => 'api_users#new'
	get 'sign_in' => 'sessions#new'
	post 'sign_in' => 'sessions#create'
	delete 'sign_out' => 'sessions#destroy'
	
	resources :api_users, only: [:index, :new, :create, :show, :update]
	resources :api_applications, only: [:new, :create, :update, :show] do
		resources :api_keys, only: [:create, :update]
		resources :app_urls, only: [:create, :destroy]
	end
	
end
