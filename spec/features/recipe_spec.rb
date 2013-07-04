require 'spec_helper'

include SharedSteps
include LoginSteps

describe 'recipe' do
  it 'can be created' do
    create_recipe
    expect(page).to have_content 'The recipe was successfully created'
  end

  it 'can be read' do
    create_recipe
    expect(page).to have_content 'Test Title'
    expect(page).to have_content 'test body'
  end

  it 'can be updated' do
    create_recipe
    click_link 'Edit'
    fill_form({
      recipe_title: 'Test Recipe Title',
      recipe_body: 'Instructions and directions'
    })
    click_button 'Update Recipe'
    expect(page).to have_content 'The recipe was successfully updated'
  end

  it 'can be deleted' do
    create_recipe
    click_link 'Edit'
    click_link 'Delete'
    click_button 'Delete'
    expect(page).to have_content 'The recipe was successfully deleted'
  end
end

def create_recipe
    login
    go_to_root
    click_link 'New Recipe'
    fill_form({
      recipe_title: 'Test Title',
      recipe_body: 'test body'
    })
    click_button 'Create Recipe'
end
