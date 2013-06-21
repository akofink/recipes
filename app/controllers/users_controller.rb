class UsersController < ApplicationController
  def create
    User.save!(params)
  end

  def show
    @user = User.find_by id: params[:id]
  end

  def update
    @user = User.find_by id: params[:id]
  end

  def destroy
    User.find_by(id: params[:id]).destroy
  end

  def index
    @users = User.order :email
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find_by id: params[:id]
  end
end
