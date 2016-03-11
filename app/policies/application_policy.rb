class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    raise Pundit::NotAuthorizedError, "must be logged in" unless user
    @user = user
    @record = record
  end
  
  def is_base?
    @user.role? :base
  end

  def index?
    is_base?
  end

end
