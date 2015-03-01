Rails.application.routes.draw do
	namespace :api, defaults: {format: 'json'} do
		namespace :v1 do
			resources :users, only: [:index, :show]
			resources :places, only: [:index, :show]
			resources :events, only: [:index, :show]
			resources :tags, only: [:index, :show]
			resources :positions, only: [:index, :show]
			
			#Catch invalid URI's, let base Api Controller take care of it
			match '*path', :to => 'base_api#routing_error', via: :all
		end
		namespace :v2 do
			get '/events/search/:query', to: 'events#search'
			get '/events/nearby', to: 'events#nearby'
			resources :events, only: [:index, :show, :create, :update, :destroy]
			resources :users, only: [:index, :show, :create] do
				resources :events, only: [:index]
			end
			resources :tags, only: [:index, :show, :create] do
				resources :events, only: [:index]
			end
			resources :places, only: [:index, :show, :create]
			resources :positions, only: [:index, :show, :create]
			
			match '/authenticate', to: 'base_api#authenticate', via: 'post'
			#Catch invalid URI's, let base Api Controller take care of it
			match '*path', :to => 'base_api#routing_error', via: :all
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
	
	#Catch invalid URI's, show 404-page
	match '*path', to: 'static_pages#routing_error', via: :all
end
