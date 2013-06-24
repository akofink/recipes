require 'spec_helper'

describe 'Session' do

  it 'should log in a user' do
    User.create(
      email: 'a@b.c',
      password: 'P@$$w0rD',
      password_confirmation: 'P@$$w0rD'
    )

    User.login('a@b.c', 'P@$$w0rD').should be_true
  end

end
