require 'spec_helper'

describe ApplicationHelper do
  include ApplicationHelper
  let(:request) { [:request] }

  describe '#link_back' do
    it 'links back' do
      allow(request).to receive(:env) { {} }
      expect(self).to receive(:link_to).and_return :root
      self.link_back
    end
  end

  describe '#md' do
    it 'formats markdown' do
      expect(md("# Header").downcase[/<h1>/]).to_not be_nil
    end
  end

  describe '#flash_class' do
    it 'aliases error to danger' do
      expect(flash_class('error')).to eq 'danger'
    end

    it 'keeps other keys as they are' do
      expect(flash_class('foo')).to eq 'foo'
    end
  end
end
