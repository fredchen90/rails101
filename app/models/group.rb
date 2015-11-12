class Group < ActiveRecord::Base
  validates :title, presence: true

  belongs_to :owner, class_name: "User", foreign_key: :user_id

  has_many :posts
  has_many :group_users
  has_many :members, through: :group_users, source: :user

  after_create :create_join

  def editable_by?(user)
    user && user == owner
  end

  def create_join
    members << owner
  end
end
