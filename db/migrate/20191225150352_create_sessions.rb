class CreateSessions < ActiveRecord::Migration[6.0]
  def change
    create_table :sessions do |t|
      t.string :name
      t.datetime :created
      t.datetime :changed
      t.references :browser, null: false, foreign_key: true

      t.timestamps
    end
  end
end
