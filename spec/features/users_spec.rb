require 'spec_helper'

feature 'User account' do
  scenario 'is created' do
    visit '/'
    click_link 'Sign Up'
    fill_in 'email', with: 'a@b.c'
    fill_in 'password', with: 'Passw0rd'
    fill_in 'password_confirmation', with: 'Passw0rd'
    click_button 'Create User'
    expect(page).to have_content('success')
  end
end
