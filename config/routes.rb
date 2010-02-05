ActionController::Routing::Routes.draw do |map|
  # sets home page
  map.root :controller => 'pages', :action => 'home'

  map.resources :snippets, :member => [:destroy_image], :collection => [:fetch_subcategories]
  map.resources :categories
  map.resources :subcategories

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
