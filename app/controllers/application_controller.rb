class ApplicationController < ActionController::Base

  protect_from_forgery

  protected

  def authenticate_user
    if session[:user_id]
      set_current_user
      return true
    else
      redirect_to :controller => 'sessions', :action => 'new'
      return false
    end
  end
  
  def set_current_user
    @current_user ||= User.find session[:user_id] if session[:user_id]
  end

  def user_has_perm?(perm)
    if authenticate_user
      unless @current_user.has_perm?(perm)
        redirect_to root_url, :alert => 'You do not have the proper permissions'
      end
    else
      return false
    end
  end

end
