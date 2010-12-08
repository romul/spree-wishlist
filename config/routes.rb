Rails.application.routes.draw do
  resources :wishlists
  resources :wished_products
  match '/wishlist', :controller => :wishlists, :action => 'show', :as => "default_wishlist"
  match '/wishlists/email_to_friend/:id', :controller => :wishlists, :action => 'email_to_friend', :as => "email_to_friend"
end