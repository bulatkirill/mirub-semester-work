# frozen_string_literal: true

# controller for a user entity to enable registration
class UsersController < ApplicationController
  skip_before_action :authenticate_request

  # controller method for creating/registering a new API user
  # POST /users
  def create
    @user = User.new(user_params)
    @user.save
    json_response(@user, :created)
  end

  private

  def user_params
    # whitelist params
    params.permit(:name, :email, :password, :password_confirmation)
  end

end