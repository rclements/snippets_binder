class AddSubcategoriesToCategories < ActiveRecord::Migration
  def self.up
    add_column :subcategories, :category_id, :integer
  end

  def self.down
    remove_column :subcategories, :category_id
  end
end
