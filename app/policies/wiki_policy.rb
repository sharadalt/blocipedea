class WikiPolicy < ApplicationPolicy
  
  class Scope 
    attr_reader :user, :scope
    
    def initialize(user, scope)
      @user = user
      @scope = scope
    end
    
    def resolve
      if user.standard?
        Wiki.where(private: false)
      elsif user.premium? or user.admin? 
        Wiki.where('user_id = ? OR private = ?', user.id, false)
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
  
  def downgrade?
    true
  end
  
end
