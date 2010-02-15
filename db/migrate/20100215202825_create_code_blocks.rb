class CreateCodeBlocks < ActiveRecord::Migration
  def self.up
    create_table :code_blocks do |t|
      t.string :title
      t.text :code
      t.string :code_type
      t.integer :snippet_id

      t.timestamps
    end
  end

  def self.down
    drop_table :code_blocks
  end
end
