class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authorize

private

  def login_with_session(user)
    session[:user_id] = user.id
  end

  def logout
    session[:user_id] = nil
  end

  def current_user
    @current_user ||= User.find_by id: session[:user_id]
  end
  helper_method :current_user

  def redirect_back(default = :root)
    redirect_to request.env['HTTP_REFERER'] ? :back : default
  end

  def authorize(args = {})
    unless current_permission(args).allow?(params[:controller], params[:action])
      flash[:error] = ['Invalid credentials']
      redirect_back
    end
  end

  def current_permission(args = {})
    @current_permission ||= Permission.new(current_user, args)
  end
  delegate :allow?, to: :current_permission
  helper_method :allow?
end
