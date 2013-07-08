class Permission
  attr_reader :user, :recipe

  def initialize(user, args = {})
    @user = user || User.new
    @recipe = Recipe.find(args[:recipe]) if args[:recipe]
  end

  def allow?(controller, action)
    case controller
    when 'recipes'
      case action
      when 'index', 'show', 'create'
        true
      when 'edit', 'destroy', 'delete'
        user && recipe == user.id
      else
        false
      end
    when 'users'
      case action
      when 'index'
        @user.admin?
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
