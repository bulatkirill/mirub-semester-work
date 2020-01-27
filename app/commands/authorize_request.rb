# frozen_string_literal: true

# Command to authorize each request to the server.
# Authorization is done with the help of JWT token
class AuthorizeRequest
  prepend SimpleCommand

  # init method to set provided headers
  #
  # @param [Hash{string->string}] HTTP headers
  def initialize(headers = {})
    @headers = headers
  end

  # executes the command
  # @return [User] user from the database if found, nil otherwise
  def call
    user
  end

  private

  attr_reader :headers

  # decode the token and retrieves the user from DB by id
  # @return [User] user in case it's found, nil otherwise
  def user
    @user ||= User.find(decoded_auth_token[:user_id]) if decoded_auth_token
    @user || errors.add(:token, 'Invalid token') && nil
  end

  # decodes the token provided in Authorization header
  # @return [ActiveSupport::HashWithIndifferentAccess] decoded token
  def decoded_auth_token
    @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
  end

  # if Authorization header is provided - extracts the content of it
  # otherwise error is added and nil returned
  # @return [string] the content of Authorization header
  def http_auth_header
    if headers['Authorization'].present?
      return headers['Authorization'].split(' ').last
    else
      errors.add(:token, 'Missing token')
    end

    nil
  end
end
