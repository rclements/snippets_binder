class SnippetId < ActiveRecord::Migration
  def self.up
    add_column :images, :snippet_id, :integer
    add_column :code_blocks, :snippet_id, :integer
  end

  def self.down
    remove_column :images, :snippet_id
    remove_column :code_blocks, :snippet_id
  end
end
