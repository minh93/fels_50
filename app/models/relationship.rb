class Relationship < ActiveRecord::Base
  include ActivityLog
  after_save :log

  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"

  validates :follower_id, presence: true
  validates :followed_id, presence: true

  def log
    create_log self.follower_id, self.followed_id, Settings.activity_type.follow_user
  end
end
