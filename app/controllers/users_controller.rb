class UsersController < ApplicationController
  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = ["The user was successfully created"]
      login_with_session(@user)
      redirect_to :account
    else
      flash[:error] = @user.errors.full_messages
      render :new
    end
  end

  def show
    set_user
  end

  def update
    set_user
    @user.update(user_params)

    if @user.errors.any?
      flash[:error] = @user.errors.full_messages
      render :edit
    else
      flash[:success] = ['User successfully updated']
      render :show
    end
  end

  def destroy
    set_user
    @user.destroy
    flash[:info] = ['User deleted']
    redirect_to :root
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
    @user ||= User.find_by(id: params[:id]) || current_user
  end

  def user_params
    params.require(:user).permit!
  end
end
