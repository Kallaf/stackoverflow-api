class Question < ApplicationRecord
  belongs_to :user
  has_many :question_tag
  has_many :question_rating
  has_many :answers
end
