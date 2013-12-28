require 'spec_helper'

feature 'Unauthorized user' do
  scenario 'tries to create a new recipe' do
    visit '/recipes/new'
    expect(page).to have_content('denied')
  end
end
