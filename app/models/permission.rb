class Permission
  attr_reader :current_user, :user, :recipe

  def initialize(user, args = {})
    @current_user = user || User.new
    @recipe = Recipe.find(args[:recipe]) if args[:recipe]
    @user = User.find(args[:user]) if args[:user]
  end

  def allow?(controller, action)
    case controller
    when 'recipes'
      case action
      when 'create', 'new'
        current_user.id
      when 'index', 'show'
        true
      when 'edit', 'update', 'destroy', 'delete'
        current_user && recipe.user_id == current_user.id
      else
        false
      end
    when 'users'
      case action
        when 'index'
          current_user.admin?
        when 'show', 'edit', 'update', 'delete', 'destroy'
          current_user.admin? || current_user.id == user.id
        when 'new', 'create'
          true
        else
          false
      end
    when 'sessions'
      true
    else
      false
    end
  end

  def recipe
    @recipe ||= args[:recipe] && args[:recipe].user_id
  end
end
