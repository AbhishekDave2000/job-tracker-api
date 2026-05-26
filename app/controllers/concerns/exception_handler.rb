module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    # Record not found → 404
    rescue_from ActiveRecord::RecordNotFound do |e|
      render json: {
        status:  "error",
        message: e.message
      }, status: :not_found
    end

    # Invalid JWT token → 401
    rescue_from JWT::DecodeError do |e|
      render json: {
        status:  "error",
        message: "Invalid token"
      }, status: :unauthorized
    end

    # Expired JWT token → 401
    rescue_from JWT::ExpiredSignature do
      render json: {
        status:  "error",
        message: "Token has expired. Please login again."
      }, status: :unauthorized
    end

    # Validation failed → 422
    rescue_from ActiveRecord::RecordInvalid do |e|
      render json: {
        status:  "error",
        message: e.message
      }, status: :unprocessable_entity
    end

    # Missing params → 400
    rescue_from ActionController::ParameterMissing do |e|
      render json: {
        status:  "error",
        message: e.message
      }, status: :bad_request
    end
  end
end
