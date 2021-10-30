class Question < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  settings do
    mappings dynamic: false do
      indexes :title, type: :text, analyzer: :english
      indexes :content, type: :text, analyzer: :english
    end
  end

  def self.search_questions(search_text)
    self.search({
      query: {
        bool: {
          must: [
          {
            multi_match: {
              query: search_text,
              fields: [:title, :content]
            }
          }]
        }
      }
    })
  end

  belongs_to :user
  has_many :question_tag
  has_many :question_rating
  has_many :answers
end
