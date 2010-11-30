require 'spree_core'
require 'spree_wishlist_hooks'

module SpreeWishlist
  class Engine < Rails::Engine

    config.autoload_paths += %W(#{config.root}/lib)

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), "../app/**/*_decorator*.rb")) do |c|
        Rails.env.production? ? require(c) : load(c)
      end
      User.class_eval do
        has_many :wishlists
      
        def wishlist
          default_wishlist = self.wishlists.first(:conditions => ["is_default = ?", true]) 
          default_wishlist ||= self.wishlists.first
          default_wishlist ||= self.wishlists.create(:name => "My wishlist", :is_default => true)
          default_wishlist.update_attribute(:is_default, true) unless default_wishlist.is_default?
          default_wishlist
        end
      end

    end

    config.to_prepare &method(:activate).to_proc
  end
end
