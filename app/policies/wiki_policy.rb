class WikiPolicy < ApplicationPolicy
  
  class Scope 
    attr_reader :user, :scope
    
    def initialize(user, scope)
      @user = user
      @scope = scope
    end
    
    def resolve
      wikis = []
      if user.admin? or user.standard? or user.premium?
        wikis = scope.all
        #scope.all
      end
    end
  end
  
  attr_reader :user, :wiki

  def initialize(user, wiki)
    @user = user
    @wiki = wiki
  end

  def update?
    user.present?
  end
  
  def index?
    true
  end
  
  def show?
    user.present?
  end
  
  def new?
    user.present?
  end
  
  def create?
    user.present?
  end
  
  def edit?
    user.present?
  end
  
  def destroy?
    user.present?
  end
  
  
end
