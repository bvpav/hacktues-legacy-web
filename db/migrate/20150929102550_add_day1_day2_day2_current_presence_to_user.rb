class AddDay1Day2Day2CurrentPresenceToUser < ActiveRecord::Migration
  def change
    add_column :users, :day1, :bool
    add_column :users, :day2, :bool
    add_column :users, :day3, :bool
    add_column :users, :current_presence, :bool
  end
end
