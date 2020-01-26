# frozen_string_literal: true

# migration for creation of the browser table
class CreateBrowsers < ActiveRecord::Migration[6.0]
  def change
    create_table :browsers do |t|
      t.string :name
      t.string :nickname
      t.string :note
      t.references :machine, null: false, foreign_key: true

      t.timestamps
    end
  end
end
