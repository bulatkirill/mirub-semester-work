# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler

  before_action :authenticate_request
  attr_reader :current_user

  private

  def authenticate_request
    @current_user = AuthorizeRequest.call(request.headers).result
    json_response({ error: 'Not Authorized' }, :unauthorized) unless @current_user
  end
end
