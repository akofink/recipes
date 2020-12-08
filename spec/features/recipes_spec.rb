require 'spec_helper'

feature 'Recipe' do
  scenario 'is shown to an unauthenticated user' do
    r = Recipe.create(title: 'jfsowjro', body: 'body', user_id: 1)
    visit "/recipes"
    expect(page).to have_content('jfsowjro')
    visit "/recipes/#{r.id}"
    expect(page).to have_content('jfsowjro')
  end

  scenario 'can be edited' do
    u = User.create(email: 'akrecipes@mailinator.com', password: 'Passw0rd', password_confirmation: 'Passw0rd')
    r = Recipe.create(title: 'jfsowjro', body: 'body', user: u)
    log_in email: u.email, password: u.password
    visit "/recipes/#{r.id}"
    expect(page).to have_content('jfsowjro')
    click_link 'Edit Recipe'
    expect(page).to have_field('Title', with: 'jfsowjro')
    click_button 'Update Recipe'
    expect(page).to have_content('The recipe was successfully updated')
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
