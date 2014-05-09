require 'spec_helper'

describe Recipe do
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
    Recipe.should respond_to :filter
  end
end
