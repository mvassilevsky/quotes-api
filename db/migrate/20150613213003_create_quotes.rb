class CreateQuotes < ActiveRecord::Migration
  def change
    create_table :quotes do |t|
      t.text :text, null: false
      t.string :author, null: false
      t.string :source
      t.integer :char_length, null: false
      t.string :category, null: false

      t.timestamps
    end
  end
end
