class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def login_with_session(user)
    session[:user_id] = user.id
  end

  def logout
    session[:user_id] = nil
  end

  def current_user
    @current_user = User.find_by id: session[:user_id]
  end
  helper_method :current_user

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = ['Access denied']
    redirect_back
  end

  def redirect_back(default = :root)
    redirect_to request.env['HTTP_REFERER'] ? :back : default
  end
end
