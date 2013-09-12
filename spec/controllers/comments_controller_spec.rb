require 'spec_helper'

include SharedSteps
include LoginSteps
include RecipeSteps
include CommentSteps

describe 'comments' do
  it 'can be created' do
    create_comment_through_ui
  end

  it 'can be destroyed'
  it 'can be updated'
end
