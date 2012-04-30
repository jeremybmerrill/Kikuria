class CreateSyntagms < ActiveRecord::Migration
  def change
    create_table :syntagms do |t|
      t.string :token
      t.string :gloss
      t.boolean :grammatical
      t.string :classOrGroup
      t.string :notes
      t.datetime :editDate
      t.integer :user_id

      t.timestamps
    end
  end
end
