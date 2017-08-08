class RecreateNonUniqueIndexOnSnippetsName < ActiveRecord::Migration[5.1]
  def self.up
    remove_index :snippets, :name => "name"
    add_index :snippets, [:name, :site_id ], :name => "name_site_id", :unique => true
  end

  def self.down
    remove_index :snippets, :name => "name_site_id"
    add_index :snippets, :name, :name => "name", :unique => true
  end
end
