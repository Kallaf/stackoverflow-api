module Api
    module V1
        class QuestionsController < ApplicationController
            def show
              question = Question.find(params[:id])
              views = question.views ? question.views : 0
              question.update(views: views + 1)
              render json: { 
                id: question.id,
                title: question.title,
                content: question.content,
                views: question.views,
                rating: question.rating
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
                  render json: { 
                    id: question.id,
                    title: question.title,
                    content: question.content
                  }, status: :created
              else
                  render json: question.errors, status: :unprocessable_entity
              end
            end
        end
    end
end
