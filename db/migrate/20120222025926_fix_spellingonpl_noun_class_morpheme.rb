class FixSpellingonplNounClassMorpheme < ActiveRecord::Migration
  def up
    remove_column :lexemes, :plNounClassMorphem
    add_column :lexemes, :plNounClassMorpheme, :string
  end

  def down
  end
end
