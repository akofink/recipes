class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :delete]
  before_action { authorize({ user: @user }) }

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
  end

  def update
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
  end

  def delete
  end

  private

  def set_user
    @user ||= User.find_by(id: params[:id]) || current_user
  end

  def user_params
    params.require(:user).permit!
  end
end
