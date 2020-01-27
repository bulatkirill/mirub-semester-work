# frozen_string_literal: true

# controller for tabs saved in the session
class TabsController < ApplicationController

  before_action :set_session
  before_action :set_tab, only: %i[show update destroy]

  # gets all tabs by session_id
  # GET /sessions/:session_id/tabs
  def index
    json_response(@session.tabs)
  end

  # creates a tab in related session
  # POST /sessions/:session_id/tabs
  def create
    @session.tabs.create!(tab_params)
    json_response(@session, :created)
  end

  # gets a tab in related session by id of the tab and session id
  # GET /sessions/:session_id/tabs/:id
  def show
    json_response(@tab)
  end

  # updates the tab by id and session id
  # PUT /sessions/:session_id/tabs/:id
  def update
    @tab.update(tab_params)
    head :no_content
  end

  # deletes a tab by id in relates session found by session id
  # DELETE /sessions/:session_id/tabs/:id
  def destroy
    @tab.destroy
    head :no_content
  end

  private

  def tab_params
    # whitelist params
    params.permit(:url, :domain, :title)
  end

  # interceptor setting tab before execution of the controller method
  def set_tab
    @tab = @session.tabs.find_by!(id: params[:id]) if @session
  end

  # interceptor setting session before execution of the controller method
  def set_session
    @session = Session.find(params[:session_id])
  end

end
