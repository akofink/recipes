require 'spec_helper'

feature 'User logs in' do
  scenario 'with valid email and password' do
    User.create(email: 'akrecipes@mailinator.com', password: 'Passw0rd', password_confirmation: 'Passw0rd')
    log_in email: 'akrecipes@mailinator.com', password: 'Passw0rd'
    expect(page).to have_content('Login successful')
  end

  scenario 'with invalid email or password' do
    log_in email: 'akrecipes@mailinator.com', password: 'password'
    expect(page).to have_content('Login failed!')
  end

  scenario 'and then logs out' do
    User.create(email: 'akrecipes@mailinator.com', password: 'Passw0rd', password_confirmation: 'Passw0rd')
    log_in email: 'akrecipes@mailinator.com', password: 'Passw0rd'
    click_link 'Logout'
    expect(page).to have_content('Logged out')
  end

  def log_in(args = {})
    visit '/'
    click_link 'Login'
    fill_in :email, with: args[:email]
    fill_in :password, with: args[:password]
    click_button 'Login'
  end
end
