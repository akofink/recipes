require 'spec_helper'

include SharedSteps
include LoginSteps

describe 'recipe' do
  it 'can be created' do
    login
    go_to_root
    click_link 'New Recipe'
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
    click_link 'Test Title'
    expect(page).to have_content 'Test Title'
    expect(page).to have_content 'test body'
  end

  it 'can be updated by the creator' do
    create_recipe
    login
    go_to_root
    click_link 'Test Title'
    click_link 'Edit'
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
    go_to_root
    click_link 'New Recipe'
    fill_form valid_ui_recipe_args
    click_button 'Create Recipe'
    logout
    login({
      email: 'foo@bar.com',
      password: 'Pass123',
      password_confirmation: 'Pass123'
    })
    go_to_root
    click_link 'Test Title'
    click_link 'Edit'
    expect(page).to have_content 'Invalid credentials'
  end

  it 'handles erroneous updates' do
    login
    go_to_root
    click_link 'New Recipe'
    fill_form valid_ui_recipe_args
    click_button 'Create Recipe'
  end

  it 'can be deleted by the creator' do
    create_recipe
    login
    go_to_root
    click_link 'Test Title'
    click_link 'Edit'
    click_link 'Delete'
    click_button 'Delete'
    expect(page).to have_content 'The recipe was successfully deleted'
  end
end

def create_recipe(args = {})
  args = valid_recipe_args.merge args
  Recipe.create!(args)
end

def go_to_recipe
  visit recipes_path(@recipe)
end

def valid_recipe(args = {})
  @recipe ||= create_recipe args
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
