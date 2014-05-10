require 'spec_helper'

describe Image do
  let(:image) { Image.new }

  describe '#thumb' do
    let(:data) { double 'data' }
    before(:each) do
      image.stub(:data).and_return data
    end

    it 'delegates to data' do
      data.should_receive :thumb
      image.thumb
    end
  end
end
