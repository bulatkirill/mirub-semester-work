# frozen_string_literal: true

# Controller for user authentication and creation of the token
class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request

  # basis controller method to handle authentication requests
  # accepts email and password as a parameter
  # POST /authenticate
  # @return [Object] return token if authentication is successful, error otherwise
  def authenticate
    command = AuthenticateUser.call(params[:email], params[:password])

    if command.success?
      json_response(auth_token: command.result)
    else
      json_response({ error: command.errors }, :unauthorized)
    end
  end
end
