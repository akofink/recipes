class PagesController < ApplicationController
  def about
  end

  private

  def action_allowed?(args = params)
    true
  end
end
