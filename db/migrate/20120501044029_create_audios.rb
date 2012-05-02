class CreateAudios < ActiveRecord::Migration
  def change
    create_table :audios do |t|
      t.string :description
      t.string :link
      t.text :notes

      t.timestamps
    end
  end
end
