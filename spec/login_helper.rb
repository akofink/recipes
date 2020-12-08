module LoginHelper
  def log_in(args = {})
    visit '/'
    click_link 'Login'
    fill_in :email, with: args[:email]
    fill_in :password, with: args[:password]
    click_button 'Login'
  end
end
