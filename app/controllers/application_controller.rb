class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  include GuestSessionsHelper
  
  def set_user
     @user=User.find(params[:id])
  end
  
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger]="ログインしてしてください。"
      redirect_to login_url
    end
  end
      
  def correct_user
    if !current_user?(@user)
      flash[:danger]="権限がありません。"
      redirect_to(root_url)
    end
  end
end
