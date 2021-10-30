module Api
    module V1
        class SearchController < ApplicationController        
            skip_before_action :authenticate, only: [:search]
            def search
                search_text = params[:search_text]
                if search_text
                    query = {
                        search_text: search_text,
                        pageNumber: params[:pageNumber] ? params[:pageNumber] : 0 ,
                        pageSize: params[:pageSize] ? params[:pageSize] : Question.max_page_size               
                    }
                    questions = Question.search_questions(query)
                    render json: {
                        status:'SUCCESS',  
                        data:questions
                    }, status: :ok
                end
            end
        end
    end
end