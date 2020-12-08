require 'spec_helper'

feature 'Recipe' do
  scenario 'is shown to an unauthenticated user' do
    r = Recipe.create(title: 'jfsowjro', body: 'body', user_id: 1)
    visit "/recipes"
    expect(page).to have_content('jfsowjro')
    visit "/recipes/#{r.id}"
    expect(page).to have_content('jfsowjro')
  end

  scenario 'is filtered' do
    r = Recipe.create(title: 'jfsowjro', body: 'body', user_id: 1)
    visit "/recipes"
    expect(page).to have_content('jfsowjro')
    visit "/recipes/filter?term=jfsow"
    expect(page).to have_content('jfsowjro')
    visit "/recipes/filter?term=asdf"
    expect(page).to have_no_xpath('/html')
  end
end
