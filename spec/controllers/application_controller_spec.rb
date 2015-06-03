require 'spec_helper'

describe ApplicationController do
  let(:application_controller) { ApplicationController.new }
  let(:user) { double User }

  describe 'private methods' do
    let(:session) { Hash.new }

    before(:each) do
      application_controller.stub(:session).and_return session
    end

    describe '#login_with_session' do
      it 'sets the user_id session variable' do
        allow(user).to receive(:id).and_return 5
        application_controller.send :login_with_session, user
        expect(session[:user_id]).to eq 5
      end
    end

    describe '#logout' do
      it 'clears the user_id session variable' do
        session[:user_id] = 5
        application_controller.send :logout
        expect(session[:user_id]).to be_nil
      end
    end

    describe '#current_user' do
      it 'finds the current user by the user_id session variable' do
        session[:user_id] = 5
        expect(User).to receive(:find_by).with id: 5
        application_controller.send :current_user
      end
    end

    describe '#redirect_back' do
      let(:request) { double 'request' }
      it 'redirects back using redirect_to' do
        request.stub(:env).and_return Hash.new
        expect(application_controller).to receive(:request).and_return request
        expect(application_controller).to receive(:redirect_to).with :root
        application_controller.send :redirect_back
      end
    end
  end
end
