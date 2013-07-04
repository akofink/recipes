require 'spec_helper'

describe User do
  before(:each) do
    @valid_params = {
      email: 'a@b.c',
      password: 'P@$$w0rD',
      password_confirmation: 'P@$$w0rD'
    }

    @user = User.new(@valid_params)
  end

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
      @user.email = email
      @user.save.should be_true
    end

    addresses[:invalid].each do |email|
      @user.email = email
      @user.save.should_not be_true
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
      @user.password = password
      @user.password_confirmation = password
      @user.save.should be_true
    end

    passwords[:invalid].each do |password|
      @user.password = password
      @user.password_confirmation = password
      @user.save.should_not be_true
    end
  end
end
