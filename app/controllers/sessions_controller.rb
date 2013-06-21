class SessionsController < ApplicationController
  def new
  end

  def create
    if u = User.login(params[:email], params[:password])
      redirect_to u
    else
      flash[:warn] = 'Login failed'
      redirect_to :login
    end
  end

  def destroy
  end
end
