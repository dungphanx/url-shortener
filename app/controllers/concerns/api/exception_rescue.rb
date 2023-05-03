module Api::ExceptionRescue
  extend ActiveSupport::Concern

  included do
    rescue_from ActionController::ParameterMissing, with: :render_400
    rescue_from ActiveRecord::RecordInvalid, with: :render_422
    rescue_from ActiveRecord::RecordNotFound, with: :render_404

    def render_400
      render json: { error_message: "Bad request" }, status: :bad_request
    end

    def render_404
      render json: { error_message: "Resource not found" }, status: :not_found
    end

    def render_422(exception)
      render json: { error_message: exception.record.errors.full_messages }, status: :unprocessable_entity
    end
  end
end
