class AddUserIdToLexemes < ActiveRecord::Migration
  def change
    add_column :lexemes, :user_id, :integer
  end
end
