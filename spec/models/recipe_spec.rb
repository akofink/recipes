require 'spec_helper'

describe Recipe do
  let(:recipe) { Recipe.new }
  let(:images) { mock 'images' }
  let(:image) { mock 'image' }

  before(:each) do
    recipe.stub(:images).and_return images
  end

  it 'requires a title' do
    @recipe = Recipe.new(
      title: '',
      body: 'test'
    )

    @recipe.should_not be_valid
  end

  it 'requires a body' do
    @recipe = Recipe.new(
      title: 'test',
      body: ''
    )

    @recipe.should_not be_valid
  end

  it 'can be filtered' do
    Recipe.should_receive(:where)
    Recipe.filter
  end

  describe '#has_images' do
    it 'determines whether this recipe has images' do
      recipe.has_images?.should be_true
    end
  end

  describe '#random_image' do
    it 'selects a random image' do
      images.should_receive(:sample).and_return image
      recipe.random_image
    end
  end

  describe '#random_thumbnail_url' do
    it 'returns a valid image url' do
      recipe.stub(:random_image).and_return Image.new
      recipe.random_thumbnail_url.class == String
    end
  end
end
