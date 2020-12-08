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

  # it 'can be filtered' do
  #   expect(Recipe).to receive(:where)
  #   Recipe.with_keyword('foo')
  # end

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

    it 'uses blank image if the recipe has no images' do
      allow(recipe).to receive(:valid_images).and_return images
      allow(images).to receive(:sample)
      expect(Image).to receive :blank
      recipe.random_image
    end
  end

  describe '#random_thumbnail_url' do
    it 'returns a valid image url' do
      allow(recipe).to receive(:random_image).and_return Image.new
      recipe.random_thumbnail_url.class == String
    end
  end

  describe '#thumb_title' do
    it 'trucates titles to 20 characters' do
      expect(recipe).to receive(:title).twice.and_return('a' * 25)
      expect(recipe.thumb_title.length).to eq 21
    end
  end
end
