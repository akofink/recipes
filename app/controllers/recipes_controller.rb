class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]

  def index
    @recipes = Recipe.all
  end

  def most_recent
    @recipes = Recipe.order(:created_at).limit(5)
    render 'index'
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
    respond_to do |format|
      format.html { redirect_to recipes_url }
      format.json { head :no_content }
    end
  end

  private
  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:title, :body)
  end
end
