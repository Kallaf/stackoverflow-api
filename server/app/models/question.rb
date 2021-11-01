class Question < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  @@max_page_size = 100
  @@trending_page_size = 5
  @@trend_key = "trending_questions"

  settings do
    mappings dynamic: false do
      indexes :title, type: :text, analyzer: :english
      indexes :content, type: :text, analyzer: :english
      indexes :answers do
        indexes :content, type: :text, analyzer: :english
      end
    end
  end

  def as_indexed_json(options = {})
    self.as_json(
      options.merge(
        only: [:id, :title, :content, :created_at, :updated_at],
        include: { answers: { only: [:id, :content] } }
      )
    )
  end

  def self.search_questions(query)
    self.search({
      from: query[:pageNumber],
      size:  query[:pageSize],
      query: {
        bool: {
          must: [
          {
            multi_match: {
              query: query[:search_text],
              fields: ["title^3", "content^2", "answers.content"]
            }
          }]
        }
      }
    })
  end

  def self.trending_questions()
    trend = self.get_trend_from_cache
    if trend.blank?
      trend = self.update_trend
    end
    JSON.parse trend.gsub('=>', ':')
  end

  def self.update_trend()
    trend = self.order("views desc")
      .limit(@@trending_page_size)
      .includes(:question_tag, :answers)
      .as_json(:include => :question_tag, :include => :answers)
    Redis.current.set(@@trend_key, trend)
    trend
  end

  def self.max_page_size
    @@max_page_size
  end
  
  def self.get_trend_from_cache
    Redis.current.get(@@trend_key)
  end

  belongs_to :user
  has_many :question_tag
  has_many :question_rating
  has_many :answers
end
