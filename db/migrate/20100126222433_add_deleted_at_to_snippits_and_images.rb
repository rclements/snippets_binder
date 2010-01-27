class AddDeletedAtToSnippitsAndImages < ActiveRecord::Migration
  def self.up
    add_column :snippets, :deleted_at, :datetime
    add_column :images, :deleted_at, :datetime
  end

  def self.down
    remove_column :images, :deleted_at
    remove_column :snippets, :deleted_at
  end
end
