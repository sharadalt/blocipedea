class Wiki < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  
  has_many :collaborators, dependent: :destroy
  has_many :collaborator_users, through: :collaborators, :source => :user 
end
