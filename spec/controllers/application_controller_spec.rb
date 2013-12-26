require 'spec_helper'

describe ApplicationController do
  let(:application_controller) { ApplicationController.new }
  let(:user) { mock_model User }

  describe 'private methods' do
    let(:session) { Hash.new }

    before(:each) do
      application_controller.stub(:session).and_return session
    end

    describe '#login_with_session' do
      it 'should set the user_id session variable' do
        user.stub(:id).and_return 5
        application_controller.send :login_with_session, user
        session[:user_id].should == 5
      end
    end

    describe '#logout' do
      it 'should clear the user_id session variable' do
        session[:user_id] = 5
        application_controller.send :logout
        session[:user_id].should be_nil
      end
    end

    describe '#current_user' do
      it 'should find the current user by the user_id session variable' do
        session[:user_id] = 5
        User.should_receive(:find_by).with id: 5
        application_controller.send :current_user
      end
    end

    describe '#redirect_back' do
      let(:request) { double 'request' }
      it 'redirects back using redirect_to' do
        request.stub(:env).and_return Hash.new
        application_controller.should_receive(:request).and_return request
        application_controller.should_receive(:redirect_to).with :root
        application_controller.send :redirect_back
      end
    end
  end
end
