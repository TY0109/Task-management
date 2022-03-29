class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  
  def set_user
     @user=User.find(params[:id])
  end
  
  
  
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
