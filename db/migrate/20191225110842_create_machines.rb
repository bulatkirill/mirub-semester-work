# frozen_string_literal: true

class CreateMachines < ActiveRecord::Migration[6.0]
  def change
    create_table :machines do |t|
      t.string :name
      t.string :nickname

      t.timestamps
    end
  end
end
