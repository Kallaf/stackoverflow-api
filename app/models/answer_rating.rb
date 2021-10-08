class AnswerRating < ApplicationRecord
  belongs_to :answer
  belongs_to :user
  validates :user, uniqueness: { scope: :answer }
end
