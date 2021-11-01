module Api
    module V1
        class ApplicationController < ActionController::API
            
            before_action :authenticate
            attr_reader :current_user_id

            def authenticate
                if request.headers["Authorization"]    
                    begin
                        @auth_header = request.headers["Authorization"]
                        decoded_token = JWT.decode(token, secret)
                        payload = decoded_token.first
                        @current_user_id = payload["user_id"]
                    rescue => exception
                        render json: { message: "Error: #{exception}" }, status: :forbidden
                    end
                else
                    render json: { message: "No Authorization header sent" }, status: :forbidden
                end
            end
            def token
                @auth_header.split(" ")[1]
            end
            def create_token(payload)
                JWT.encode(payload, secret)
            end
            def secret
                Rails.application.secrets.secret_key_base
            end
        end
    end
end