class Api::V1::AuthenticationController < ApplicationController
    skip_before_action :authenticate_request, only: [ :login, :register ]

    def register
        user = User.create!(user_params)
        token = JsonWebToken.encode(user_id: user.id)
        render json: { token: token, user: user }, status: :created
    end

    def login
        user = User.find_by!(email: params[:email].downcase)

        if user.authenticate(params[:password])
            token = JsonWebToken.encode(user_id: user.id)
            render json: { token: token, user: user }, status: :ok
        else
            render json: { error: "Invalid Password" }, status: :unauthorized
        end
    end

    private
    def user_params
        params.permit(:first_name, :last_name, :email, :password)
    end
end
