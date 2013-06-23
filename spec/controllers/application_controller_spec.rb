require 'spec_helper'

describe 'ApplicationController' do
  before(:each) do
    @ac = ApplicationController.new
  end

  it 'should retrieve the current user' do
    @ac.current_user
  end
end
