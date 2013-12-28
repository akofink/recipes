require 'spec_helper'

feature 'Recipe' do
  scenario 'is shown to an unauthenticated user' do
    r = Recipe.create(title: 'jfsowjro', body: 'body', user_id: 1)
    visit "/recipes"
    expect(page).to have_content('jfsowjro')
    visit "/recipes/#{r.id}"
    expect(page).to have_content('jfsowjro')
  end
end
