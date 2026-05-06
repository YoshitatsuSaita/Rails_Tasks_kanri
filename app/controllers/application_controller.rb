class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  before_action :set_current_user
  
  def set_current_user
    @user = current_user
  end

  def logged_in_user
    if !logged_in?
      flash[:danger] = 'ログインしてください。'
      redirect_to login_path
    end
  end

  def admin_user
    if !current_user.admin?
      redirect_to root_path
    end
  end

  def correct_user
    if current_user.id != params[:id].to_i
      redirect_to root_path
    end
  end

  def admin_or_correct_user 
    if !current_user.admin? && current_user.id != params[:id].to_i
      redirect_to root_path
    end
  end

end
