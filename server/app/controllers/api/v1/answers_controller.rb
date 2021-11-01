module Api
    module V1
        class AnswersController < ApplicationController
            def answer_question
                question = Question.find_by(id: params[:question_id])
                if question
                    answer = Answer.new(
                        question_id: params[:question_id],
                        user_id: @current_user_id,
                        content: params[:content],
                        rating: 0
                    )
                    
                    if answer.save
                        render json: { 
                          id: answer.id,
                          question_id: answer.question_id,
                          user_id: answer.user_id,
                          content: answer.content,
                          rating: answer.rating
                        }, status: :created
                    else
                        render json: answer.errors, status: :unprocessable_entity
                    end
                end
            end
        end
    end
end
