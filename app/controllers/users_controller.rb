class UsersController < ApplicationController
  def initialize
    super
    @errors = []
  end

  def create
    @user = User.create(user_params)
    @errors = @user.errors

    if @errors.any?
      render :new
    else
      render :show
    end
  end

  def show
    set_user
  end

  def update
    set_user
    @user.update(user_params)
    @errors = @user.errors

    if @errors.any?
      render :edit
    else
      render :show
    end
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
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
