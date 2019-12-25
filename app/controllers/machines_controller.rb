# frozen_string_literal: true

# Controller for user machines
class MachinesController < ApplicationController
  before_action :set_machine, only: %i[show update destroy]

  # GET /machines
  def index
    @browsers = Machine.all
    json_response(@browsers)
  end

  # POST /machines
  def create
    @machine = Machine.create!(machine_params)
    json_response(@machine, :created)
  end

  # GET /machines/:id
  def show
    json_response(@machine)
  end

  # PUT /machines/:id
  def update
    @machine.update(machine_params)
    head :no_content
  end

  # DELETE /machines/:id
  def destroy
    @machine.destroy
    head :no_content
  end

  private

  def machine_params
    # whitelist params
    params.permit(:name, :nickname)
  end

  def set_machine
    @machine = Machine.find(params[:id])
  end
end
