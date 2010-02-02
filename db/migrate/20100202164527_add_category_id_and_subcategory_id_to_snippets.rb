class AddCategoryIdAndSubcategoryIdToSnippets < ActiveRecord::Migration
  def self.up
    add_column :snippets, :category_id, :integer
    add_column :snippets, :subcategory_id, :integer
  end

  def self.down
    remove_column :snippets, :subcategory_id
    remove_column :snippets, :category_id
  end
end
