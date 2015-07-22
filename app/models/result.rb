class Result < ActiveRecord::Base
  belongs_to :lesson
  belongs_to :word
  belongs_to :answer

  scope :answered, ->{where.not answer_id: nil}
end
