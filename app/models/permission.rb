class Permission < Struct.new(:user, :args)
  def allow?(controller, action)
    user && recipe == user.id
  end

  def recipe
    @recipe ||= args[:recipe] && args[:recipe].user_id
  end
end
