class SessionsController < ApplicationController
  def new
  end

  def create
    if u = User.login(params[:email], params[:password])
      login_with_session(u)
      flash[:success] = 'Login successful'
      redirect_to :account
    else
      flash[:warning] = 'Login failed!'
      redirect_to :login
    end
  end

  def destroy
    logout
    flash[:info] = 'Logged out'
    redirect_to :login
  end

  private

  def action_allowed?(args = params)
    case args[:action]
    when 'new', 'create'
      @error_message = 'Already logged in.'
      !current_user
    when 'destroy'
      true
    end
  end
end

