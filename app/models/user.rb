class User < ActiveRecord::Base
  include Slugreate

	has_many :posts
	has_many :comments
  has_many :votes
  has_many :follower_relationships, class_name: 'Relationship', foreign_key: 'leader_id'
  has_many :leader_relationships,   class_name: 'Relationship', foreign_key: 'follower_id'
  has_many :followers,  through: :follower_relationships, source: :follower
  has_many :leaders  ,  through: :leader_relationships,   source: :leader

  has_secure_password validations: false

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, on: :create, length: { minimum: 3 }

  slugable_column :username

  def admin?
    self.role == 'admin'
  end

  def moderator?
    self.role == 'moderator'
  end
  
end