require 'spec_helper'

describe Recipe do
  let(:recipe) { Recipe.new }
  let(:images) { mock 'images' }
  let(:image) { mock 'image' }
  let(:env) { double 'env' }

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

    it 'uses google to find an image if the recipe has no images' do
      images.stub(:sample)
      recipe.should_receive :google_image
      recipe.random_image
    end
  end

  describe '#random_thumbnail_url' do
    it 'returns a valid image url' do
      recipe.stub(:random_image).and_return Image.new
      recipe.random_thumbnail_url.class == String
    end
  end

  describe '#google_image' do
    before(:each) do
      recipe.stub(:title).and_return "kitty"
      images.stub(:any?)
      Rails.stub(:env).and_return env
      env.stub(:test?)
      env.stub(:production?)
      images.stub(:first).and_return Image.new
      Image.stub(:new).and_return image
      image.stub(:save).and_return true
      image.stub :remote_data_url=
      image.stub :recipe=
    end

    it 'adds an image to a recipe without any images' do
      images.should_receive :first
      recipe.google_image
    end
  end
end
