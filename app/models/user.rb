class User < ActiveRecord::Base
  before_save ->{self.email = email.downcase}

  has_many :activities, dependent: :destroy
  has_many :lessons, dependent: :destroy
  has_many :results, through: :lessons

  has_many :following_relationships, class_name: "Relationship",
    foreign_key: "follower_id", dependent: :delete_all
  has_many :followers_relationships, class_name: "Relationship",
    foreign_key: "followed_id", dependent: :delete_all

  has_many :following, through: :following_relationships, source: :followed
  has_many :followers, through: :followers_relationships, source: :follower

  has_secure_password

  validates :email,
    format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i},
    presence: true, length: {maximum: Settings.user.maximum_characters},
    uniqueness: {case_sensitive: false}
  validates :password,
    length: {minimum: Settings.user.minimum_characters}
  validates :name, presence: true,
    length: {maximum: Settings.user.maximum_characters}
end
