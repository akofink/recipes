class UsersController < ApplicationController
  def create
    @user = User.create!(user_params)
    redirect_to @user
  end

  def show
    set_user
  end

  def update
    set_user
  end

  def destroy
    set_user.destroy
    redirect_to User
  end

  def index
    @users = User.order :email
  end

  def new
    @user = User.new
  end

  def edit
    set_user
  end

  def delete
    set_user
  end

  private

  def set_user
    @user = User.find_by id: params[:id]
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
