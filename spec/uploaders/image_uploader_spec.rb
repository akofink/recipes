require 'spec_helper'

describe ImageUploader do
  let(:image_uploader) { ImageUploader.new }
  let(:model) { double 'model' }

  before(:each) do
    allow(image_uploader).to receive(:model).and_return model
    allow(model).to receive(:recipe_id).and_return 'recipe_id'
    allow(model).to receive(:class).and_return 'Model'
  end

  describe '#store_dir' do
    it 'returns a valid storage directory' do
      expect(image_uploader.store_dir[/(\w+\/)+(\w+)?/]).to_not be_nil
    end
  end

  describe '#extension_white_list' do
    it 'contains whitelisted upload formats' do
      expect(image_uploader.extension_white_list).to_not be_empty
    end
  end
end
