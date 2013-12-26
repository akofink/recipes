require 'spec_helper'

feature 'User signs up' do
  scenario 'with valid email and password' do
    sign_up email: 'akrecipes@mailinator.com', password: 'Passw0rd'
    expect(page).to have_content('The user was successfully created')
  end

  scenario 'with invalid email or password' do
    sign_up email: 'akrecipes@mailinator.com', password: 'password'
    expect(page).to have_content('Password must meet the security requirements')
  end

  def sign_up(args = {})
    visit '/'
    click_link 'Sign Up'
    fill_in :email, with: args[:email]
    fill_in :password, with: args[:password]
    fill_in :password_confirmation, with: args[:password]
    click_button 'Create User'
  end
end
