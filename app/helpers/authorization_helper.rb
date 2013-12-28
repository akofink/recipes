module AuthorizationHelper
  def authorize
    unless action_allowed? || (current_user && current_user.admin?)
      flash[:warning] = "#{params[:controller]}##{params[:action]} denied for those parameters"
      redirect_back
    end
  end

  def action_allowed?(args = params)
  end
end
