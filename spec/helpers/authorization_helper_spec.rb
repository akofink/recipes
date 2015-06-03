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
      allow(current_user).to receive(:admin?).and_return nil
    end

    it 'checks if the action is allowed' do
      expect(self).to receive :action_allowed?
      authorize
    end

    it 'redirects back on unsuccessful authorization' do
      expect(self).to receive :redirect_back
      authorize
    end

    it 'sets the flash warning message on unsuccessful authorization' do
      authorize
      expect("#{flash[:warning]}"[/denied/]).to_not be_nil
    end
  end

  describe "#action_allowed?" do
    it 'defaults to nil (unauthorized)' do
      allow(self).to receive(:params)
      expect(action_allowed?).to be_nil
    end
  end
end
