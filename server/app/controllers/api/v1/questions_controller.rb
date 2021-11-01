module Api
    module V1
        class QuestionsController < ApplicationController 
            skip_before_action :authenticate, only: [:show, :trend]
            def show
              question = Question.includes(:question_tag, :answers)
                                 .where(id: params[:id]).first
              if question
                views = question.views ? question.views : 0
                question.update(views: views + 1)
                render json: { 
                  id: question.id,
                  title: question.title,
                  content: question.content,
                  views: question.views,
                  rating: question.rating,
                  tags: question.question_tag,
                  answers: question.answers
                }, status: :ok
              else
                render status: :not_found
              end
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

            def trend
              questions = Question.trending_questions
              render json: questions, status: :ok 
            end

        end
    end
end
