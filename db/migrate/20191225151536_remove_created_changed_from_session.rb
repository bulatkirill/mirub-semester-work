# frozen_string_literal: true

# migration for removing extra columns
class RemoveCreatedChangedFromSession < ActiveRecord::Migration[6.0]
  def change
    remove_column :sessions, :created
    remove_column :sessions, :changed
  end
end
