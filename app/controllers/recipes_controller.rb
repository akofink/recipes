class RecipesController < ApplicationController
  before_action :set_recipe, only: [ :show, :edit, :update, :destroy, :delete ]
  before_action { authorize({ recipe: @recipe }) }

  def index
    @recipes = Recipe.all
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
    @recipe ||= Recipe.find(params[:id])
    @images ||= @recipe.images + [ Image.new ]
  end

  def recipe_params
    params
      .require(:recipe)
      .permit(
        :title,
        :body,
        :user_id,
        images_attributes: [ :data, :data_cache ]
      )
  end
end
