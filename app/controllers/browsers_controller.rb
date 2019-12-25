# frozen_string_literal: true

# Controller for users browsers registered on his machines
class BrowsersController < ApplicationController
  before_action :set_machine
  before_action :set_browser, only: %i[show update destroy]

  # GET /machines/:machine_id/browsers
  def index
    json_response(@machine.browsers)
  end

  # POST /machines/:machine_id/browsers
  def create
    @machine.browsers.create!(browser_params)
    json_response(@machine, :created)
  end

  # GET /machines/:machine_id/browsers/:id
  def show
    json_response(@browser)
  end

  # PUT /machines/:machine_id/browsers/:id
  def update
    @browser.update(browser_params)
    head :no_content
  end

  # DELETE /machines/:machine_id/browsers/:id
  def destroy
    @browser.destroy
    head :no_content
  end

  private

  def browser_params
    # whitelist params
    params.permit(:name, :nickname)
  end

  def set_browser
    @browser = @machine.browsers.find_by!(id: params[:id]) if @machine
  end

  def set_machine
    @machine = Machine.find(params[:machine_id])
  end
end
