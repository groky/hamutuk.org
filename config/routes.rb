HamutukOrg::Application.routes.draw do 


  get "sessions/new"

  #the root page
  root :to => "home#index"
 
  #get "home/index"

  #get "home/about"

  #get "home/contact"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # The home routes
  match 'about',   :to => "home#about"
  match 'contact', :to => "home#contact"
  
 
  
  # The user routes
  resources :users, :controller => 'user'
  #devise_for :users 
  #get "user/login"
  #get "user/register"
  
  match 'users'           ,:to => "user#create"  
  match 'user/show/:id'   ,:to => "user#show" 
  match 'register'        ,:to => "user#register"
  match 'users/:id/edit'  ,:to => "user#edit"
  #match 'login'        ,:to  => "user#login"
  
  # The sessions routes
  resources :sessions,  :only => [:new, :create, :destroy]
  
  match 'login',        :to => "sessions#new"
  match 'logout',       :to => "sessions#destroy"
  
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
  
  
  #TODO - change this as soon as it works!!
  default_url_options :host => "localhost:3000"
end
