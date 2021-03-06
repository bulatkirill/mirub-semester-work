# frozen_string_literal: true

# migration for creation of the machine table
class CreateMachines < ActiveRecord::Migration[6.0]
  def change
    create_table :machines do |t|
      t.string :name
      t.string :nickname

      t.timestamps
    end
  end
end
