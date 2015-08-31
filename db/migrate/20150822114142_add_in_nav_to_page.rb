class AddInNavToPage < ActiveRecord::Migration
  def change
    add_column :pages, :in_nav, :boolean, default: false
  end
end
