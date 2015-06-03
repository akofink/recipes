require 'spec_helper'

describe User do
  let(:user) { User.new(valid_params) }
  let(:valid_params) {
    {
      email: 'a@b.c',
      password: 'P@$$w0rD',
      password_confirmation: 'P@$$w0rD'
    }
  }

  it 'checks the email address' do
    addresses = {
      valid: [
        'a@b.c',
        '@@@.@',
        'A!$S@baR.)#$f.asro'
      ],
      invalid: [
        '',
        'a',
        'a@',
        'a@a',
        'a@a.'
      ]
    }

    addresses[:valid].each do |email|
      user.email = email
      expect(user).to be_valid
    end

    addresses[:invalid].each do |email|
      user.email = email
      expect(user).to_not be_valid
    end
  end

  it 'checks the password' do
    passwords = {
      valid: [
        'aA2aga',
        'aA#32A'
      ],
      invalid: [
        'aA3%2',
        'aA#tw',
        'aaaaaa',
        'aAAAAA',
        'a22222',
        'a#####',
        'AAAAAA',
        'A22222',
        'A#####',
        '222222',
        '2#####',
        '######'
      ]
    }

    passwords[:valid].each do |password|
      user.password = password
      user.password_confirmation = password
      expect(user).to be_valid
    end

    passwords[:invalid].each do |password|
      user.password = password
      user.password_confirmation = password
      expect(user).to_not be_valid
    end
  end

  it 'logs in a user' do
    user = User.new(
      email: 'a@b.c',
      password: 'Pass123'
    )

    User.stub(:find_by).and_return(user)
    expect(user).to receive(:authenticate)
    User.login('a@b.c', 'Pass123')
  end

  it 'determines admin status' do
    expect(user).to receive(:admin).and_return 1
    expect(user.admin?)
  end
end
