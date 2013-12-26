class SessionsController < ApplicationController
  def new
  end

  def create
    if u = User.login(params[:email], params[:password])
      login_with_session(u)
      flash[:success] = ['Login successful']
      redirect_to :account
    else
      flash[:error] = ['Login failed!']
      redirect_to :login
    end
  end

  def destroy
    logout
    flash[:info] = ['Logged out']
    redirect_to :login
  end
end
