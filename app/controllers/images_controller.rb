class ImagesController < ApplicationController
  def new
    @recipe ||= Recipe.find_by_id(params[:id]) || Recipe.new
    @image ||= Image.new
    render partial: 'form'
  end

  def create
  end

  def delete
  end

  def destroy
  end

  private

  def action_allowed?
    true
  end
end
