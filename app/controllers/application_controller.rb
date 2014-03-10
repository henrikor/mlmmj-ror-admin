class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  private
  
  def moderator?
  	redirect_to(root_url) unless User.moderator?(current_user)
  end
  def can_admin?
  	redirect_to(root_url) unless current_user.admin?
  end
  def can_moderate?
  	redirect_to(root_url) unless Liste.lists_for_user(current_user).include?(@liste)
  end

end
