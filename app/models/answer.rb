class Answer < ActiveRecord::Base
  belongs_to :word

  has_many :results

  scope :suffer, ->{order "RANDOM()"}
end
