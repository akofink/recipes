require 'spec_helper'

describe AuthorizationHelper do
  include AuthorizationHelper

  describe "#authorize" do
    let(:params) { {} }
    let(:current_user) { 'current_user' }
    let(:flash) { {} }
    let(:action_allowed?) { }
    let(:redirect_back) { }

    before(:each) do
      current_user.stub(:admin?).and_return
    end

    it 'checks if the action is allowed' do
      should_receive :action_allowed?
      authorize
    end

    it 'redirects back on unsuccessful authorization' do
      should_receive :redirect_back
      authorize
    end

    it 'sets the flash warning message on unsuccessful authorization' do
      authorize
      "#{flash[:warning]}"[/denied/].should_not be_nil
    end
  end

  describe "#action_allowed?" do
    it 'defaults to nil (unauthorized)' do
      action_allowed?.should be_nil
    end
  end
end
