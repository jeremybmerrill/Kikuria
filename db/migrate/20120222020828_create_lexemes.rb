class CreateLexemes < ActiveRecord::Migration
  def change
    create_table :lexemes do |t|
      t.string :token
      t.string :gloss
      t.string :pos
      t.string :root
      t.string :sgNounClassMorpheme
      t.integer :sgNounClassNumber
      t.string :plNounClassMorphem
      t.integer :plNounClassNumber
      t.string :classOrGroup
      t.string :transcription
      t.datetime :editDate
      t.string :sgTranscription
      t.string :plTranscription
      t.string :infTranscription
      t.text :additionalForms
      t.text :notes

      t.timestamps
    end
  end
end
