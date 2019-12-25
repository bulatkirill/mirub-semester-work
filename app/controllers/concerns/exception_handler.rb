# frozen_string_literal: true

# module for defining a exception handlers through the whole application
module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    # find method in ActiveRecord can throw this exception
    rescue_from ActiveRecord::RecordNotFound do |e|
      json_response({message: e.message}, :not_found)
    end

    # create! method can raise an exception if saving an instance fails.
    # This handler helps us to recover from the exception
    rescue_from ActiveRecord::RecordInvalid do |e|
      json_response({message: e.message}, :unprocessable_entity)
    end
  end
end