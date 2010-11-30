class WishlistMailer < ActionMailer::Base
  default_url_options[:host] = Spree::Config[:site_url]
  default :from => Spree::Config[:mails_from]
  
  def email_wishlist_to_friend(user, wishlist, email)
    subject = email[:subject].blank? ? 'Wishlist' : email[:subject]
    @mail = email
    @wishlist = wishlist
    mail(:to => email[:email], :subject => subject)
  end
end
