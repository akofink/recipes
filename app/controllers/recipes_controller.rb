class RecipesController < ApplicationController
  before_action :set_user
  before_action :set_recipe, only: [ :show, :edit, :update, :destroy, :delete ]
  before_action { authorize({ recipe: @recipe }) }

  def index
    @recipes ||= @user.recipes if @user
    @recipes ||= Recipe.order(:title)
  end

  def show
  end

  def new
    @recipe = Recipe.new
  end

  def edit
  end

  def create
    @recipe = Recipe.create(recipe_params)
    flash[:error] = @recipe.errors.full_messages

    if flash[:error].any?
      render :new
    else
      flash[:success] = ["The recipe was successfully created"]
      redirect_to @recipe
    end
  end

  def update
    @recipe.update(recipe_params)

    flash[:error] = @recipe.errors.full_messages

    if flash[:error].any?
      render :new
    else
      flash[:success] = ["The recipe was successfully updated"]
      redirect_to @recipe
    end
  end

  def destroy
    @recipe.destroy
    flash[:info] = ['The recipe was successfully deleted']
    redirect_to :root
  end

  def delete
  end

  private

  def set_recipe
    @recipe ||= Recipe.find_by id: params[:id]
    @images ||= @recipe.images + [ Image.new ]
  end

  def set_user
    @user ||= User.find_by id: params[:user_id]
  end

  def recipe_params
    params
      .require(:recipe)
      .permit(
        :title,
        :body,
        :user_id,
        images_attributes: [
          :id,
          :data,
          :user_id,
          :recipe_id
        ]
      )
  end
end
