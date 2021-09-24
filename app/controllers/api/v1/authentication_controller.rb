module Api
    module V1
        class AuthenticationController < ApplicationController
            skip_before_action :authenticate, only: [:login]

            def login
                @user = User.find_by(email: params[:email])
                if @user
                    if(@user.authenticate(params[:password]))    
                        payload = { user_id: @user.id}
                        secret = ENV['SECRET_KEY_BASE'] || Rails.application.secrets.secret_key_base
                        token = create_token(payload)
                        render json: 
                        {
                            token: token
                        }
                    else
                        render json: { message: "Authentication failed" }, status: :unauthorized
                    end
                else
                    render json: { message: "Could not find user"}, status: :not_found
                end
            end
        end
    end
end
