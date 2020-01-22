class ChangeMachineIdToDeviceId < ActiveRecord::Migration[6.0]
  def change
    rename_column :browsers, :machine_id, :device_id
  end
end
