require 'spec_helper'

describe Comment do
  let(:comment) { Comment.new }

  it 'belongs to a recipe' do
    comment.should(respond_to :recipe)
  end

  it 'belongs to a user' do
    comment.should(respond_to :user)
  end

  describe '.chronological' do
    it 'orders by updated_at' do
      Comment.should_receive(:order).with(:updated_at)
      Comment.chronological
    end
  end
end
