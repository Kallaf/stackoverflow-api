module Api
    module V1
        class QuestionRatingsController < ApplicationController
            def rate_question
                question = Question.find_by(id: params[:question_id])
                if question
                    rating = QuestionRating.find_by(
                        question_id: params[:question_id],
                        user_id: @current_user_id
                    )
                    rating_val = 0
                    if params[:rating] > 0
                        rating_val = 1
                    elsif params[:rating] < 0
                        rating_val = -1
                    end
                    if rating
                        rating.update(rating: rating_val)
                    else 
                        rating = QuestionRating.new(
                            question_id: params[:question_id],
                            user_id: @current_user_id,
                            rating: rating_val
                        )
                    end
                    
                    if rating.save
                        question_rating = QuestionRating.where(question_id: question.id).sum('rating')
                        question.update(rating: question_rating)
                        render json: { 
                          id: rating.id,
                          question_id: rating.question_id,
                          user_id: rating.user_id,
                          rating: rating.rating
                        }
                    else
                        render json: rating.errors, status: :unprocessable_entity
                    end
                else
                    render json: { message: "Question not found"}, status: :not_found
                end
            end
        end
    end
end
