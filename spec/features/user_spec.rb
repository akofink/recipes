require 'spec_helper'

describe 'user' do
  before(:each) do
    @user ||= User.create!(
      email: 'a@b.c',
      password: 'Pass123',
      password_confirmation: 'Pass123'
    )
  end

  it 'can log in' do
    visit '/'
    click_link 'Login'
    within('form') do
      fill_in 'email', with: 'a@b.c'
      fill_in 'password', with: 'Pass123'
      click_button 'Login'
    end
    expect(page).to have_content 'Login successful'
  end

  it 'can log out' do
    visit '/'
    click_link 'Login'
    within('form') do
      fill_in 'email', with: 'a@b.c'
      fill_in 'password', with: 'Pass123'
      click_button 'Login'
    end
    click_link 'Logout'
    expect(page).to have_content 'Logged out'
  end
end
