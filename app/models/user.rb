class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable, :lockable,
         :recoverable, :rememberable, :trackable, :validatable
  
  has_many :wikis, :dependent => :destroy
  has_many :collaborators, dependent: :destroy
  has_many :collaborator_wikis, through: :collaborators, source: :wiki
  
  enum role: [:admin, :standard, :premium]
  before_save { self.role ||= :standard }
 
  def collaborator_for(wiki, user)
     collaborators.where(wiki_id: wiki.id, user_id: user.id).first
  end
end
