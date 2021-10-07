module Api
    module V1
        class QuestionsController < ApplicationController
            def show
              question = Question.includes(:question_tag).where(id: params[:id]).first
              views = question.views ? question.views : 0
              question.update(views: views + 1)
              render json: { 
                id: question.id,
                title: question.title,
                content: question.content,
                views: question.views,
                rating: question.rating,
                tags: question.question_tag
              }
            end
            def create
              question = Question.new(
                  title: params[:title], 
                  content: params[:content],
                  user_id: @current_user_id,
                  views: 0,
                  rating: 0
              )
              if question.save
                  questionTags = []
                  for tag in params[:tags]
                    questionTag = QuestionTag.new(
                        question_id: question.id, 
                        tag_id: tag[:id]
                    )
                    if questionTag.save
                      questionTags.push(questionTag.attributes.slice('tag_id'))
                    end
                  end
                  render json: { 
                    id: question.id,
                    title: question.title,
                    content: question.content,
                    questionTags: questionTags
                  }, status: :created
              else
                  render json: question.errors, status: :unprocessable_entity
              end
            end
        end
    end
end
