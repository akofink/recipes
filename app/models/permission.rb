class Permission
  attr_reader :current_user, :user, :recipe

  def initialize(user, args = {})
    @current_user = user || User.new
    @recipe = Recipe.find(args[:recipe]) if args[:recipe]
    @user = User.find(args[:user]) if args[:user]
  end

  def allow?(controller, action, args = {})
    return true if current_user.admin?
    case controller
    when 'recipes'
      case action
      when 'create', 'new'
        current_user.id
      when 'index', 'show', 'add_image'
        true
      when 'edit', 'update', 'destroy', 'delete'
        current_user && recipe.user_id == current_user.id
      end
    when 'users'
      case action
      when 'index'
        current_user.admin?
      when 'show', 'edit', 'update', 'delete', 'destroy'
        current_user.admin? || current_user.id == user.id
      when 'new', 'create'
        true
      end
    when 'comments'
      case action
      when 'edit'
        current_user == args[:comment].user
      end
    end
  end

  def recipe
    @recipe ||= args[:recipe] && args[:recipe].user_id
  end
end
