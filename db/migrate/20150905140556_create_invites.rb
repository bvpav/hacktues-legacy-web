class CreateInvites < ActiveRecord::Migration
  def change
    create_table :invites do |t|
      t.integer :from_id
      t.integer :to_id

      t.timestamps null: false
    end
  end
end
