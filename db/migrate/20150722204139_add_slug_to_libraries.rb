class AddSlugToLibraries < ActiveRecord::Migration
  def change
    add_column :libraries, :slug, :string, null: false
  end
end
