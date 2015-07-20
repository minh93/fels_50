class User < ActiveRecord::Base
  attr_accessor :remember_token
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
  validates :password, allow_nil: true,
    length: {minimum: Settings.user.minimum_characters}
  validates :name, presence: true,
    length: {maximum: Settings.user.maximum_characters}

  def User.digest string
    cost = if ActiveModel::SecurePassword.min_cost
      BCrypt::Engine::MIN_COST
    else
      BCrypt::Engine.cost
    end
    BCrypt::Password.create string, cost: cost
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attributes remember_digest: User.digest(remember_token)
  end

  def authenticated? remember_token
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password? remember_token
  end

  def forget
    update_attributes remember_digest: nil
  end
end
