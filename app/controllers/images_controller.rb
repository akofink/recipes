class ImagesController < ApplicationController
  def new
    @image = Image.new
    render partial: 'form'
  end

  def create
  end

  def delete
  end

  def destroy
  end
end
