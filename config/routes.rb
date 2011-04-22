JmvcCommunity::Application.routes.draw do
  
  resources :posts do
    collection do
      get 'tagged/:tag', :as => :tagged, :action => 'tag'
      get 'in-bucket/:bucket', :action => 'bucket', :as => :in_bucket
      get 'user/:user_id', :action => 'user', :as => :by_user
    end
  end
  
  resources :users
  
# customize controller action if needed to render individual registration form for each role    
# Example:
# match "/editors/sign_up" => "user_registrations#new_editor", :as => :editor_signup

#  'user_registrations_controller.rb' with the action #new_editor
# def new_editor
#   build_resource({})
# end
# 
# and the registration form in 'views/user_registrations/new_editor.html.erb'
#

  #devise_for :admins, :class_name => 'Admin'
  #as :admin do
  #  match "/admins/sign_up" => "devise/registrations#new", :as => :admin_signup
  #end
  

  #match "bucket/:slug" => 'buckets#show', :as => :bucket
  #match "tag/:tag" => 'buckets#by_tag', :as => :tagged_with

  match "/auth/:provider/callback" => "sessions#create"
  match "/signout" => "sessions#destroy", :as => :signout

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
  
  root :to => "posts#index"
  
end
