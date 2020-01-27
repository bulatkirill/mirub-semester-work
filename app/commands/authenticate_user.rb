# frozen_string_literal: true

# Command to validate  user credentials and create JWT for a user
class AuthenticateUser
  prepend SimpleCommand

  # init method to set parameters of the command
  #
  # @param [string] email
  # @param [string] password
  def initialize(email, password)
    @email = email
    @password = password
  end

  # action method to execute command
  def call
    JsonWebToken.encode(user_id: user.id) if user
  end

  private

  attr_accessor :email, :password

  # finds user by his email and validate if the provided password is correct
  #
  # @return [User, null] in case user is found and password is correct returns user, nil otherwise
  def user
    user = User.find_by_email(email)
    return user if user&.authenticate(password)

    errors.add :user_authentication, 'invalid credentials'
    nil
  end
end
