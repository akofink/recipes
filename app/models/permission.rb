class Permission
  attr_reader :current_user, :user, :recipe
  attr_accessor :error_message

  def initialize(args = {})
    @current_user = args[:current_user]
    @recipe = Recipe.find(args[:recipe]) if args[:recipe]
    @user = User.find(args[:user]) if args[:user]
  end

  def allow?(controller, action, args = {})
    return true if current_user.try :admin?
    case controller
    when 'recipes'
      case action
      when 'create', 'new'
        current_user
      when 'index', 'show', 'add_image'
        true
      when 'edit', 'update', 'destroy', 'delete'
        current_user && recipe.user == current_user
      end
    when 'users'
      case action
      when 'show', 'edit', 'update', 'delete', 'destroy'
        current_user == user
      when 'new', 'create'
        true
      end
    when 'sessions'
      case action
      when 'new', 'create'
        @error_message = 'Already logged in.'
        !current_user
      when 'destroy'
        true
      end
    when 'comments'
      case action
      when 'create', 'new'
        current_user
      when 'update', 'edit', 'destroy'
        current_user == args[:comment].user
      end
    end
  end
end
