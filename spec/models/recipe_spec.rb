require 'spec_helper'

describe Recipe do
  let(:recipe) { Recipe.new }
  let(:images) { double 'images' }
  let(:image) { double 'image' }
  let(:env) { double 'env' }

  before(:each) do
    allow(recipe).to receive(:images).and_return images
    allow(images).to receive(:present?).and_return [:i]
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
      allow(recipe).to receive(:valid_images).and_return images
      expect(images).to receive(:sample).and_return image
      recipe.random_image
    end

    it 'uses google to find an image if the recipe has no images' do
      allow(recipe).to receive(:valid_images).and_return images
      allow(images).to receive(:sample)
      expect(recipe).to receive :google_image
      recipe.random_image
    end
  end

  describe '#random_thumbnail_url' do
    it 'returns a valid image url' do
      allow(recipe).to receive(:random_image).and_return Image.new
      recipe.random_thumbnail_url.class == String
    end
  end

  describe '#google_image' do
    before(:each) do
      allow(recipe).to receive(:title).and_return "kitty"
      allow(images).to receive(:any?)
      allow(Rails).to receive(:env).and_return env
      allow(env).to receive(:test?)
      allow(env).to receive(:production?)
      allow(images).to receive(:first).and_return Image.new
      allow(Image).to receive(:new).and_return image
      allow(image).to receive(:save).and_return true
      allow(image).to receive :remote_data_url=
      allow(image).to receive :recipe=
      allow(Google::Search::Image).to receive(:new).and_return []
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
