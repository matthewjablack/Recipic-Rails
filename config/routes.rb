Rails.application.routes.draw do
	root :to => 'pages#home'

	namespace :api do
    namespace :v1 do
      devise_scope :user do
        post 'registrations' => 'registrations#create', :as => 'register'
        post 'sessions' => 'sessions#create', :as => 'login'
        delete 'sessions' => 'sessions#destroy', :as => 'logout'
      end
      post 'images/photo_identify' => 'images#photo_identify', as: 'photo_identify'
      get 'items' => 'items#index', as: 'items_search'
      get 'recipes' => 'items#index', as: 'recipe_search'
			

    end
  end

	devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks", registrations: 'registrations'}
	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

	resources :users

  resources :recipes
end
