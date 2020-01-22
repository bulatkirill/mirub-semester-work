# frozen_string_literal: true

# Controller for user devices
class DevicesController < ApplicationController
  before_action :set_device, only: %i[show update destroy]

  # GET /devices
  def index
    @devices = Device.all.includes(:browsers)
    json_response(@devices, :ok, [:browsers])
  end

  # POST /devices
  def create
    @device = Device.create!(device_params)
    json_response(@device, :created)
  end

  # GET /devices/:id
  def show
    json_response(@device)
  end

  # PUT /devices/:id
  def update
    @device.update(device_params)
    head :no_content
  end

  # DELETE /devices/:id
  def destroy
    @device.destroy
    head :no_content
  end

  private

  def device_params
    # whitelist params
    params.permit(:name, :nickname)
  end

  def set_device
    @device = Device.find(params[:id])
  end
end
