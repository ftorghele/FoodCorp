FoodCorp::Application.routes.draw do

  resources :comments
	
  resources :meal_arrangements
    
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks",
                                       :registrations => "registrations" }

  resources :users do
    match 'info' => :info
  end

  resources :fellowships
  
  resources :meals
	match 'location/new' => 'Meals#create_location', :as => 'create_user_location'
	match 'location/update' => 'Meals#update_location', :as => 'update_user_location'
    match 'recipes' => 'Meals#recipes', :as => 'recipes'
    match 'meals/:id/:status' => 'Meals#show', :as => 'meal_arrangement_status'
    
  controller :meals do
    match 'meals/create_comment' => :create_comment
  end

  controller :messages do
    match 'messages/in' => :inbox
    match 'messages/out' => :outbox
  end
  resources :messages

  controller :pages do
     match 'about' => :about
     match 'imprint' => :imprint
     match 'terms' => :terms
     match 'tour' => :tour
  end

  controller :ajax do
     match 'ajax/calendar' => :calendar
     match 'ajax/updatemap' => :update_map
     match 'ajax/following' => :following
     match 'ajax/followed' => :followed
  end

  root :to => "meals#index"

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
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
