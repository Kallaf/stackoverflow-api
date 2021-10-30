module Api
    module V1
        class SearchController < ApplicationController        
            skip_before_action :authenticate, only: [:search]
            def search
                search_text = params[:search_text]
                
                if search_text
                    questions = Question.search_questions(search_text)
                    render json: {
                        status:'SUCCESS',  
                        data:questions
                    }, status: :ok
                end
            end
        end
    end
end