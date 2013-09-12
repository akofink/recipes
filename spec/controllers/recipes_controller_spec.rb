require 'spec_helper'

include RecipeSteps
include SharedSteps
include LoginSteps

describe 'recipes' do
  it 'can be created' do
    login
    go_to_root
    first(:link, 'New Recipe').click
    fill_form valid_ui_recipe_args({
      recipe_title: ''
    })
    click_button 'Create Recipe'
    expect(page).to have_content "Title can't be blank"
    fill_form valid_ui_recipe_args
    click_button 'Create Recipe'
    expect(page).to have_content 'The recipe was successfully created'
  end

  it 'can be read by anyone' do
    create_recipe
    login
    go_to_root
    first(:link, 'Test Title').click
    expect(page).to have_content 'Test Title'
    expect(page).to have_content 'test body'
  end

  it 'can be updated by the creator' do
    login
    create_recipe_through_ui
    go_to_root
    first(:link, 'Test Title').click
    first(:link, 'Edit').click
    fill_form({
      recipe_title: '',
    })
    click_button 'Update Recipe'
    expect(page).to have_content "Title can't be blank"
    fill_form({
      recipe_title: 'Test Recipe Title',
      recipe_body: 'Instructions and directions'
    })
    click_button 'Update Recipe'
    expect(page).to have_content 'The recipe was successfully updated'
  end

  it 'can only be updated by the creator (and admins)' do
    login
    create_recipe_through_ui
    logout
    login({
      email: 'foo@bar.com',
      password: 'Pass123',
      password_confirmation: 'Pass123'
    })
    visit "recipes/#{Recipe.where(title: 'Test Title').last.id}/edit"
    expect(page).to have_content 'Invalid credentials'
  end

  it 'handles erroneous updates' do
    login
    go_to_root
    first(:link, 'New Recipe').click
    fill_form valid_ui_recipe_args
    click_button 'Create Recipe'
  end

  it 'can be deleted by the creator' do
    login
    create_recipe_through_ui
    go_to_root
    first(:link, 'Test Title').click
    first(:link, 'Edit').click
    first(:link, 'Delete').click
    expect(page).to have_content 'The recipe was successfully deleted'
  end
end
