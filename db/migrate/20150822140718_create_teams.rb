class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.integer :captain_id
      t.text :members_id
      t.string :project_name
      t.text :project_desc
      t.text :technologies

      t.timestamps null: false
    end
  end
end
