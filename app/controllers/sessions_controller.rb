class SessionsController < ApplicationController
  def initialize
    super
    @errors = []
  end

  def new
  end

  def create
    if u = User.login(params[:email], params[:password])
      redirect_to u
    else
      @errors += ['Login failed!']
      render :new
    end
  end

  def destroy
  end
end
