class AddRoomToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :room, :integer
  end
end
