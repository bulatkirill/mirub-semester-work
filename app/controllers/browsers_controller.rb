# frozen_string_literal: true

# Controller for users browsers registered on his devices
class BrowsersController < ApplicationController
  before_action :set_device
  before_action :set_browser, only: %i[show update destroy]

  # GET /devices/:device_id/browsers
  def index
    json_response(@device.browsers)
  end

  # POST /devices/:device_id/browsers
  def create
    @device.browsers.create!(browser_params)
    json_response(@device, :created)
  end

  # GET /devices/:device_id/browsers/:id
  def show
    json_response(@browser)
  end

  # PUT /devices/:device_id/browsers/:id
  def update
    @browser.update(browser_params)
    head :no_content
  end

  # DELETE /devices/:device_id/browsers/:id
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
    @browser = @device.browsers.find_by!(id: params[:id]) if @device
  end

  def set_device
    @device = Device.find(params[:device_id])
  end
end
