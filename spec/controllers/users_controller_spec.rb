require 'spec_helper'

include SharedSteps
include LoginSteps

describe 'user' do
  before(:each) do
    valid_user
  end

  describe 'accounts' do
    before(:each) do
      create_user({
        email: 'bob@dole.com'
      })
    end

    it 'can be viewed' do
      create_user({
        email: 'ad@min.com',
        admin: true
      })
      login({ email: 'ad@min.com' })
      visit '/users'
      expect(page).to have_content 'bob@dole.com'
      expect(page).to have_content 'a@b.c'
    end
  end

  describe 'account' do
    it 'can be created' do
      go_to_root
      click_link 'Sign Up'
      fill_form({
        email: 'a@b.com',
        password: 'Pass123',
      })
      click_button 'Create User'
      expect(page).to have_content "Password confirmation can't be blank"
      fill_form({
        password: 'Pass123',
        password_confirmation: 'Pass123'
      })
      click_button 'Create User'
      expect(page).to have_content 'The user was successfully created'
    end

    it 'can be read' do
      login
      expect(page).to have_content @user.email
    end

    it 'can be updated' do
      login
      click_link 'Account'
      click_link 'Edit'
      fill_form({
        email: 'a@b.com',
        password: 'Pass123',
      })
      click_button 'Update User'
      expect(page).to have_content "Password confirmation can't be blank"
      fill_form({
        email: 'foo@bar.com',
        password: 'PassWord123',
        password_confirmation: 'PassWord123'
      })
      click_button 'Update User'
      expect(page).to have_content 'User successfully updated'
    end

    it 'can be deleted' do
      login
      click_link 'Account'
      click_link 'Edit'
      click_link 'Delete'
      click_button 'Delete'
      expect(page).to have_content 'User deleted'
    end
  end

  describe 'login/logout' do
    it 'can log in' do
      login
      expect(page).to have_content 'Login successful'
    end

    it 'can log out' do
      login
      click_link 'Logout'
      expect(page).to have_content 'Logged out'
    end

    it 'is shown an error on unsuccessful login' do
      login({ email: 'a@b.cc' })
      expect(page).to have_content 'Login failed'
    end
  end
end

