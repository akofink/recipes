require 'spec_helper'

describe ApplicationHelper do
  include ApplicationHelper
  let(:request) { [:request] }

  describe '#link_back' do
    it 'links back' do
      request.stub(:env) { {} }
      self.should_receive(:link_to).and_return :root
      self.link_back
    end
  end

  describe '#md' do
    it 'formats markdown' do
      md("# Header").downcase[/<h1>/].should_not be_nil
    end
  end
end
