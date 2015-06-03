require 'spec_helper'

describe Comment do
  let(:comment) { Comment.new }

  it 'belongs to a recipe' do
    expect(comment).to respond_to :recipe
  end

  it 'belongs to a user' do
    expect(comment).to respond_to :user
  end

  describe '.chronological' do
    it 'orders by created_at' do
      expect(Comment).to receive(:order).with(:created_at)
      Comment.chronological
    end
  end
end
