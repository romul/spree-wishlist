class WishlistsController < Spree::BaseController
  resource_controller
  helper :products
  
  create.before do
    @wishlist.user = current_user
  end

  update.wants.js { 
    flash[:notice] = nil
    render :js => "alert('#{t :updated_successfully}');"
  }
  
  def email_to_friend
    @wishlist = object
    if request.post?
      if params[:email].blank?
        flash[:error] = t('email_address_missing')
      else
        WishlistMailer.email_wishlist_to_friend(current_user, @wishlist, params).deliver
        flash[:notice] = t('wishlist_email_sent')
        redirect_to wishlist_path(@wishlist)
      end
    end
  end
  private

    def object
      @object ||= end_of_association_chain.find_by_access_hash(param)
      @object ||= current_user.wishlist if current_user
      @object
    end

    def can_read?
      object && object.can_be_read_by?(current_user)
    end
end
