FAMOUS::Application.routes.draw do


  
  root to: 'main#index'

  resources :songs, only: [:edit, :destroy] do
    member do 
      post 'unlike', to: 'likes#unlike'
      post 'like', to: 'likes#like'
    end
  end
  resources :bands do 
    resources :requests, only: [:new, :create, :update, :destroy]
    resources :songs, only: [:new, :create]
    member do 
      post :join
      post :leave
    end
  end
  resources :genres
  
  devise_for :users, controllers: {omniauth_callbacks: "omniauth_callbacks"}
  
  resources :users, only: :show
  namespace :public do
    resources :users, only: :show
  end
  resources :venues
  resources :staticpages

  get 'search' => 'main#search', :as => 'search'
  post 'has_venue', to: 'users#has_venue', as: 'has_venue_true'


  
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
