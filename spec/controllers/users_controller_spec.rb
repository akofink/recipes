require 'spec_helper'

describe UsersController do
  let(:users_controller) { UsersController.new }
  let(:user) { mock_model User }
  let (:errors) { [:errors] }

  describe 'public methods' do
    before(:each) do
      users_controller.stub(:flash).and_return Hash.new
      users_controller.stub :login_with_session
      users_controller.stub :redirect_to
      users_controller.stub :render
      users_controller.stub(:user_params).and_return Hash.new
      users_controller.stub(:set_user).and_return user
      users_controller.instance_variable_set :@user, user
      errors.stub(:full_messages).and_return ['']
    end

    describe '#create' do
      it 'creates a user from valid params' do
        User.should_receive(:new).with({}).and_return user
        user.should_receive(:save).and_return true
        users_controller.create
      end

      it 'handles invalid params' do
        User.should_receive(:new).with({}).and_return user
        user.should_receive(:save).and_return false
        user.should_receive(:errors).and_return errors
        users_controller.create
      end
    end

    describe '#show' do
      it 'sets the current user' do
        users_controller.show
      end
    end

    describe '#update' do
      before(:each) do
        user.stub :update
      end

      it 'updates the model' do
        user.should_receive :update
        users_controller.update
        users_controller.flash[:success].should_not be_nil
      end

      it 'handles validation errors' do
        user.should_receive(:errors).at_least(:once).and_return errors
        users_controller.update
        users_controller.flash[:error].should_not be_nil
      end
    end

    describe '#destroy' do
      it 'destroys the user model' do
        user.should_receive :destroy
        users_controller.destroy
        users_controller.flash[:info].should_not be_nil
      end
    end

    describe '#index' do
      it 'orders all users by email' do
        User.should_receive(:order).with :email
        users_controller.index
      end
    end

    describe '#new' do
      it 'uses a new user' do
        User.should_receive :new
        users_controller.new
      end
    end

    describe '#edit' do
      it 'uses an existing user' do
        users_controller.should_receive :set_user
        users_controller.edit
      end
    end

    describe '#delete' do
      it 'uses the existing user' do
        users_controller.should_receive :set_user
        users_controller.delete
      end
    end
  end

  describe 'private methods' do
    let(:params) { Hash.new }

    before(:each) do
      users_controller.stub(:params).and_return params
      params.stub :permit!
    end

    describe '#set_user' do
      it 'finds the current user' do
        User.should_receive(:find_by).and_return user
        users_controller.send :set_user
      end
    end

    describe '#user_params' do
      it 'requires user' do
        params.should_receive(:require).with(:user).and_return params
        users_controller.send :user_params
      end
    end
  end
end
