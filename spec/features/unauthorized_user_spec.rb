require 'spec_helper'

feature 'Unauthorized user' do
  scenario 'tries to view another user' do
    u = User.create(
      email: 'a@b.c',
      password: 'Passw0rd',
      password_confirmation: 'Passw0rd'
    )
    visit "/users/#{u.id}"
    expect(page).to have_content('denied')
  end

  scenario 'tries to edit another user' do
    u = User.create(
      email: 'a@b.c',
      password: 'Passw0rd',
      password_confirmation: 'Passw0rd'
    )
    visit "/users/#{u.id}/edit"
    expect(page).to have_content('denied')
  end

  scenario 'tries to create a new recipe' do
    visit '/recipes/new'
    expect(page).to have_content('denied')
  end

  scenario 'tries to edit a recipe' do
    r = Recipe.create(title: 'title', body: 'body', user_id: 1)
    visit "/recipes/#{r.id}/edit"
    expect(page).to have_content('denied')
  end
end
