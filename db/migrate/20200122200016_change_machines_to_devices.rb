# frozen_string_literal: true

# change the name of the table
class ChangeMachinesToDevices < ActiveRecord::Migration[6.0]
  def change
    rename_table :machines, :devices
  end
end
