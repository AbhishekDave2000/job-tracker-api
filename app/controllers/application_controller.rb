class ApplicationController < ActionController::API
  include ExceptionHandler

  before_action :authenticate_request

  private

  def authenticate_request
    @current_user = JsonWebToken.decode(auth_token)[:user_id]
                                .then { |id| User.find(id) }
  rescue ActiveRecord::RecordNotFound
    render json: { error: "User not found" }, status: :unauthorized
  end

  def auth_token
    request.headers.fetch("Authorization", "").split(" ").last
  end

  def current_user
    @current_user
  end
end
