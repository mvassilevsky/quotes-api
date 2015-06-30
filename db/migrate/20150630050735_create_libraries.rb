class CreateLibraries < ActiveRecord::Migration
  def change
    create_table :libraries do |t|
      t.string :name, null: false
      t.text :description
      t.integer :owner_id, null: false
      t.integer :access_level, null: false

      t.timestamps null: false
    end

    add_column :quotes, :library_id, :integer
  end
end
