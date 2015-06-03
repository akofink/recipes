require 'spec_helper'

describe Image do
  let(:image) { Image.new }

  describe '#thumb' do
    let(:data) { double 'data' }
    before(:each) do
      allow(image).to receive(:data).and_return data
    end

    it 'delegates to data' do
      expect(data).to receive :thumb
      image.thumb
    end
  end
end
