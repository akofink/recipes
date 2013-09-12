module RecipeSteps
  def create_recipe_through_ui(args = {})
    go_to_root
    first(:link, 'New Recipe').click
    fill_form args.merge(valid_ui_recipe_args)
    click_button 'Create Recipe'
  end

  def create_recipe(args = {})
    create Recipe, valid_recipe_args.merge(args)
  end

  def go_to_recipe
    visit "/recipes/#{@recipe.id}"
  end

  def valid_recipe(args = {})
    @recipe ||= create_recipe(args)
  end

  def valid_recipe_args(args = {})
    {
      title: 'Test Title',
      body: 'test body',
      user_id: 1
    }.merge args
  end

  def valid_ui_recipe_args(args = {})
    {
      recipe_title: 'Test Title',
      recipe_body: 'test body'
    }.merge args
  end
end
