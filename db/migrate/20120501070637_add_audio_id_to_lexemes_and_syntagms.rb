class AddAudioIdToLexemesAndSyntagms < ActiveRecord::Migration
  def change
    add_column :lexemes, :audio_id, :integer
    add_column :syntagms, :audio_id, :integer
  end
end
