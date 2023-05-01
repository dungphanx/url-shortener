module Api::ExceptionRescue
  extend ActiveSupport::Concern

  included do
    rescue_from ActionController::ParameterMissing, with: :render400
    rescue_from ActiveRecord::RecordInvalid, with: :render422
    rescue_from ActiveRecord::RecordNotFound, with: :render404

    def render400
      render json: {erorr_message: "Bad request"}, status: :bad_request
    end

    def render404
      render json: {erorr_message: "Resource not found"}, status: :not_found
    end

    def render422(exception)
      render json: {erorr_message: exception.record.errors.full_messages}, status: :unprocessable_entity
    end
  end
end
