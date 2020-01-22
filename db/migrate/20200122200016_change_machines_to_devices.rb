class ChangeMachinesToDevices < ActiveRecord::Migration[6.0]
  def change
    rename_table :machines, :devices
  end
end
