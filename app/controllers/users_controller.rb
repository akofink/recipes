class UsersController < ApplicationController
  load_and_authorize_resource

  def create
    @user = User.create(user_params)
    flash[:error] = @user.errors.full_messages

    if flash[:error].any?
      render :new
    else
      flash[:success] = ["The user was successfully created"]
      redirect_to :login
    end
  end

  def show
    set_user
  end

  def update
    set_user
    @user.update(user_params)
    flash[:error] = @user.errors.full_messages

    if flash[:error].any?
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
    params.require(:user).permit!
  end
end
