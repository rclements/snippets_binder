class CreateSnippets < ActiveRecord::Migration
  def self.up
    create_table :snippets do |t|
      t.string :name
      t.timestamps
      t.text :description
    end
  end

  def self.down
    drop_table :snippets
  end
end
