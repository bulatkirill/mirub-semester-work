# frozen_string_literal: true

class TabsController < ApplicationController

  before_action :set_session
  before_action :set_tab, only: %i[show update destroy]

  # GET /sessions/:session_id/tabs
  def index
    json_response(@session.tabs)
  end

  # POST /sessions/:session_id/tabs
  def create
    @session.tabs.create!(tab_params)
    json_response(@session, :created)
  end

  # GET /sessions/:session_id/tabs/:id
  def show
    json_response(@tab)
  end

  # PUT /sessions/:session_id/tabs/:id
  def update
    @tab.update(tab_params)
    head :no_content
  end

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

  def set_tab
    @tab = @session.tabs.find_by!(id: params[:id]) if @session
  end

  def set_session
    @session = Session.find(params[:session_id])
  end

end
