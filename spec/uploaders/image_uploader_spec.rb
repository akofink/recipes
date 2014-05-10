require 'spec_helper'

describe ImageUploader do
  let(:image_uploader) { ImageUploader.new }
  let(:model) { double 'model' }

  before(:each) do
    image_uploader.stub(:model).and_return model
    model.stub(:recipe_id).and_return 'recipe_id'
    model.stub(:class).and_return 'Model'
  end

  describe '#store_dir' do
    it 'returns a valid storage directory' do
      image_uploader.store_dir[/(\w+\/)+(\w+)?/].should_not be_nil
    end
  end

  describe '#extension_white_list' do
    it 'contains whitelisted upload formats' do
      image_uploader.extension_white_list.should_not be_empty
    end
  end
end
