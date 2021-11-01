module Api
    module V1
        class TagsController < ApplicationController        
            skip_before_action :authenticate
            def index
                tags = Tag.order('created_at DESC')
                render json: {
                    status:'SUCCESS', 
                    message:'Load tags', 
                    data:tags
                }, status: :ok
            end

            def show
                tag = Tag.find(params[:id])
                render json: {
                    status:'SUCCESS', 
                    message:'Load tag', 
                    data:tag
                }, status: :ok
            end
        end
    end
end