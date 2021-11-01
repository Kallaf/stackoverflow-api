module Api
    module V1
        class UsersController < ApplicationController        
            skip_before_action :authenticate, only: [:create]
            def create
                @user = User.new(email: params[:email], password: params[:password])

                if @user.save
                    payload = { user_id: @user.id}
                    token = create_token(payload)
                    render json: 
                    {
                        email: @user.email
                    }, status: :created
                else
                    render json: @user.errors, status: :unprocessable_entity
                end
            end
        end
    end
end