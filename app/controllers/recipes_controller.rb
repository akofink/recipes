class RecipesController < ApplicationController
  before_action { authorize({ recipe: @recipe }) }

  def index
    @recipes ||= user.recipes.order(:title) if user
    @recipes ||= Recipe.order(:title)
    @recipes = @recipes.page params[:page]
  end

  def filter
    @recipes ||= user.recipes if user
    @recipes ||= Recipe.all

    term = "%#{params[:term]}%"
    @recipes = @recipes
    .where(
      "title ilike ? OR body ilike ?",
      term,
      term
    )
    .order(:title)
    .page params[:page]
    render partial: 'all'
  end

  def show
    set_recipe
  end

  def new
    @recipe = Recipe.new
  end

  def edit
    set_recipe
  end

  def create
    @recipe = Recipe.new(recipe_params)

    if @recipe.save
      flash[:success] = ["The recipe was successfully created"]
      redirect_to @recipe
    else
      flash[:error] = @recipe.errors.full_messages
      render :new
    end
  end

  def update
    set_recipe
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
    set_recipe
    @recipe.destroy
    flash[:info] = ['The recipe was successfully deleted']
    redirect_to :root
  end

  def delete
    set_recipe
  end

  private

  def set_recipe
    @recipe ||= Recipe.find_by id: params[:id]
    @images ||= @recipe.images + [ Image.new ]
  end

  def user
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
