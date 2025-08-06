class UserPolicy
  attr_reader :current_user, :user

  def initialize(current_user, user)
    @current_user = current_user
    @user = user
  end

  def show?
   true
  end

  def show_photos?
    user == current_user ||
     !user.private? || 
     user.followers.include?(current_user)
  end

  def feed?
    true
  end

  class Scope
  def initialize(current_user, scope)
    @current_user = current_user
    @scope = scope
  end

  def resolve
    @scope.all # or some filtering logic
  end
end
end
