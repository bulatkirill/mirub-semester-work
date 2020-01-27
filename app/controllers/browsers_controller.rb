# frozen_string_literal: true

# Controller for users browsers registered on his devices
class BrowsersController < ApplicationController
  before_action :set_device
  before_action :set_browser, only: %i[show update destroy]

  # gets a list of all browsers related to device by device_id
  # GET /devices/:device_id/browsers
  # @return [Array] array of browsers
  def index
    json_response(@device.browsers)
  end

  # adds a browser to a collection of devices' browsers
  # POST /devices/:device_id/browsers
  # @return [Device] device to which browser was added
  def create
    @device.browsers.create!(browser_params)
    json_response(@device, :created)
  end

  # gets a browser by id and by related device_id
  # GET /devices/:device_id/browsers/:id
  # @return [Browser] found browser
  def show
    json_response(@browser)
  end

  # updates the browser by id
  # PUT /devices/:device_id/browsers/:id
  def update
    @browser.update(browser_params)
    head :no_content
  end

  # deletes the browser by id
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

  # interceptor setting browser before execution of the controller method
  def set_browser
    @browser = @device.browsers.find_by!(id: params[:id]) if @device
  end

  # interceptor setting device before execution of the controller method
  def set_device
    @device = Device.find(params[:device_id])
  end
end
