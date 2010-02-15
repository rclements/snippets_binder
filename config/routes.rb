ActionController::Routing::Routes.draw do |map|
  # sets home page
  map.root :controller => 'pages', :action => 'home'
  
  map.login "login", :controller => "user_sessions", :action => "new"
  map.logout "logout", :controller => "user_sessions", :action => "destroy"
  map.resources :snippets, :member => [:destroy_image], :collection => [:fetch_subcategories]
  map.resources :categories
  map.resources :subcategories
  map.resources :code_blocks
  map.resource :user_session
  map.resources :users
  map.resources :comments
  map.resource :account, :controller => "users"
  map.resources :users

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
