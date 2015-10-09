class AddDeclarationToUser < ActiveRecord::Migration
  def change
    add_column :users, :declaration, :boolean
  end
end
