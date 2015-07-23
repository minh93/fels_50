class Lesson < ActiveRecord::Base
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
    self.results.unanswered.count == 0
  end
end
