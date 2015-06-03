require 'spec_helper'

describe Recipe do
  let(:recipe) { Recipe.new }
  let(:images) { double 'images' }
  let(:image) { double 'image' }
  let(:env) { double 'env' }

  before(:each) do
    recipe.stub(:images).and_return images
    images.stub(:present?).and_return [:i]
  end

  it 'requires a title' do
    @recipe = Recipe.new(
      title: '',
      body: 'test'
    )

    expect(@recipe).to_not be_valid
  end

  it 'requires a body' do
    @recipe = Recipe.new(
      title: 'test',
      body: ''
    )

    expect(@recipe).to_not be_valid
  end

  it 'can be filtered' do
    expect(Recipe).to receive(:where)
    Recipe.filter
  end

  describe '#has_images' do
    it 'determines whether this recipe has images' do
      expect(recipe.has_images?)
    end
  end

  describe '#random_image' do
    it 'selects a random image' do
      recipe.stub(:valid_images).and_return images
      expect(images).to receive(:sample).and_return image
      recipe.random_image
    end

    it 'uses google to find an image if the recipe has no images' do
      recipe.stub(:valid_images).and_return images
      images.stub(:sample)
      expect(recipe).to receive :google_image
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
      Google::Search::Image.stub(:new).and_return []
    end

    it 'adds an image to a recipe without any images' do
      expect(Image).to receive :new
      recipe.google_image
    end
  end

  describe '#thumb_title' do
    it 'trucates titles to 20 characters' do
      expect(recipe).to receive(:title).twice.and_return('a' * 25)
      expect(recipe.thumb_title.length).to eq 21
    end
  end
end
