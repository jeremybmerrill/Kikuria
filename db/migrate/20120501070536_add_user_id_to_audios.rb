class AddUserIdToAudios < ActiveRecord::Migration
  def change
    add_column :audios, :user_id, :integer
  end
end
