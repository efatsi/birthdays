class AddPreferencesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :one_week, :boolean, :default => true
    add_column :users, :day_of,   :boolean, :default => true
  end
end
