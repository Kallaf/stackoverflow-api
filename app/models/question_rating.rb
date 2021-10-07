class QuestionRating < ApplicationRecord
  belongs_to :question
  belongs_to :user
  validates :user, uniqueness: { scope: :question }
end
