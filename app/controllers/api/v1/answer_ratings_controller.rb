module Api
    module V1
        class AnswerRatingsController < ApplicationController
            def rate_answer
                answer = Answer.find_by(id: params[:answer_id])
                if answer
                    rating = AnswerRating.find_by(
                        answer_id: params[:answer_id],
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
                        rating = AnswerRating.new(
                            answer_id: params[:answer_id],
                            user_id: @current_user_id,
                            rating: rating_val
                        )
                    end
                    
                    if rating.save
                        answer_rating = AnswerRating.where(answer_id: answer.id).sum('rating')
                        answer.update(rating: answer_rating)
                        render json: { 
                        id: rating.id,
                        answer_id: rating.answer_id,
                        user_id: rating.user_id,
                        rating: rating.rating
                        }
                    else
                        render json: rating.errors, status: :unprocessable_entity
                    end
                else
                    render json: { message: "Answer not found"}, status: :not_found
                end
            end
        end
    end
end
