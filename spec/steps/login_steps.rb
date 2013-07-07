module LoginSteps
  def login(args = {})
    args = valid_user_args args
    valid_user args
    go_to_root
    click_link 'Login'
    fill_form({
      email: args[:email],
      password: args[:password]
    })
    click_button 'Login'
  rescue
  end

  def logout
    go_to_root
    click_link 'Logout'
  end

  def valid_user(args = {})
    @user ||= create_user args
  end

  def create_user(args = {})
    args = valid_user_args.merge args
    User.create!(args)
  end

  def valid_user_args(args = {})
    {
      email: 'a@b.c',
      password: 'Pass123',
      password_confirmation: 'Pass123'
    }.merge args
  end
end
