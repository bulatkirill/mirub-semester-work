# frozen_string_literal: true

class RemoveCreatedChangedFromSession < ActiveRecord::Migration[6.0]
  def change
    remove_column :sessions, :created
    remove_column :sessions, :changed
  end
end
