class Lesson < ActiveRecord::Base
  include ActivityLog
  after_update :log
  
  belongs_to :user
  belongs_to :category

  has_many :results, dependent: :destroy
  has_many :words, through: :results
  has_many :answers, through: :results

  accepts_nested_attributes_for :results

  before_create lambda {
    words = self.category.words.order("RANDOM()").limit 20
    self.words = words
  }

  def finished?
    !self.mark.nil?
  end

  def log
    create_log self.user_id, self.id, Settings.activity_type.take_lesson
  end
end
