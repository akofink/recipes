class RecipesController < ApplicationController
  def create
    @recipe = Recipe.new(recipe_params)

    if @recipe.save
      flash[:success] = "The recipe was successfully created"
      redirect_to @recipe
    else
      flash[:error] = @recipe.errors.full_messages
      render :new
    end
  end

  def destroy
    set_recipe
    @recipe.destroy
    flash[:info] = 'The recipe was successfully deleted'
    redirect_to :root
  end

  def edit
    set_recipe
  end

  def filter
    @recipes = recipes.filter params[:term]
    render partial: 'all'
  end

  def index
    paginated_recipes
  end

  def new
    @recipe = Recipe.new
  end

  def show
    set_recipe
  end

  def update
    if recipe.update(recipe_params)
      flash[:success] = "The recipe was successfully updated"
      redirect_to @recipe
    else
      render :new
    end
  end

  private

  def recipes
    @recipes = (
      (user.recipes if user) ||
      (Recipe.all)
    ).order(:title)
  end

  def paginated_recipes
    @recipes = recipes.page params[:page]
  end

  def set_recipe
    @recipe ||= Recipe.find_by id: params[:id]
    @images ||= @recipe.images + [ Image.new ]
    @recipe
  end
  alias_method :recipe, :set_recipe

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

  def action_allowed?(args = params)
    case args[:action]
    when 'create', 'new'
      current_user
    when 'index', 'show', 'add_image', 'filter'
      true
    when 'edit', 'update', 'destroy', 'delete'
      current_user && recipe.user == current_user
    end
  end
end
