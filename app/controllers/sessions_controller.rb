# frozen_string_literal: true

# session controller
class SessionsController < ApplicationController

  before_action :set_browser
  before_action :set_session, only: %i[show update destroy]

  # GET /browsers/:browser_id/sessions
  def index
    json_response(@browser.sessions)
  end

  # POST /browsers/:browser_id/sessions
  def create
    @browser.sessions.create!(session_params)
    json_response(@browser, :created)
  end

  # GET /browsers/:browser_id/sessions/:id
  def show
    json_response(@session)
  end

  # PUT /browsers/:browser_id/sessions/:id
  def update
    @session.update(session_params)
    head :no_content
  end

  # DELETE /browsers/:browser_id/sessions/:id
  def destroy
    @session.destroy
    head :no_content
  end

  private

  def session_params
    # whitelist params
    params.permit(:name)
  end

  def set_session
    @session = @browser.sessions.find_by!(id: params[:id]) if @browser
  end

  def set_browser
    @browser = Browser.find(params[:browser_id])
  end

end
