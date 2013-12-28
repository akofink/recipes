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

  scenario 'is updated' do
    User.create(
      email: 'a@b.c',
      password: 'Passw0rd',
      password_confirmation: 'Passw0rd'
    )
    visit '/'
    click_link 'Login'
    fill_in 'email', with: 'a@b.c'
    fill_in 'password', with: 'Passw0rd'
    click_button 'Login'
    click_link 'Edit'
    fill_in 'email', with: 'abc@b.c'
    click_button 'Update User'
    expect(page).to have_content('success')
  end
end
