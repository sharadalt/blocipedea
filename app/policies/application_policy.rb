class ApplicationPolicy
  attr_reader :user, :wiki

  def initialize(user, wiki)
    raise Pundit::NotAuthorizedError, "must be logged in" unless user
    @user = user
    @wiki = wiki
  end
  
  def index?
    user.present?
  end

end
