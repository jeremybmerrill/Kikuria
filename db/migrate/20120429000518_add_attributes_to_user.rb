class AddAttributesToUser < ActiveRecord::Migration
  def change
    add_column :users, :displayname, :string
    add_column :users, :profilestuff, :string
    add_column :users, :preferredOrth, :string
  end
end
