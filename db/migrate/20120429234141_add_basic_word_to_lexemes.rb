class AddBasicWordToLexemes < ActiveRecord::Migration
  def change
    add_column :lexemes, :basicWord, :boolean, :default => :false
  end
end
