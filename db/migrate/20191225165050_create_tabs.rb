# frozen_string_literal: true

class CreateTabs < ActiveRecord::Migration[6.0]
  def change
    create_table :tabs do |t|
      t.string :url
      t.string :domain
      t.string :title
      t.references :session, null: false, foreign_key: true

      t.timestamps
    end
  end
end
