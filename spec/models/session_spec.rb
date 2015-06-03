require 'spec_helper'

describe 'Session' do

  it 'logs in a user' do
    User.create(
      email: 'a@b.c',
      password: 'P@$$w0rD',
      password_confirmation: 'P@$$w0rD'
    )

    expect(User.login('a@b.c', 'P@$$w0rD'))
  end

end
