module LoginSteps
  def login(email = 'a@b.c', password = 'Pass123')
    go_to_root
    click_link 'Login'
    fill_form({
      email: email,
      password: password
    })
    click_button 'Login'
  end

  def valid_user
    @user ||= User.create!(
      email: 'a@b.c',
      password: 'Pass123',
      password_confirmation: 'Pass123'
    )
  end
end
