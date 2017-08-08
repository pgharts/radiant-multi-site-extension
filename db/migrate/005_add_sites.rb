class AddSites < ActiveRecord::Migration[5.1]
  def self.up
    [:layouts, :snippets, :users].each do |table|
      add_column table, :site_id, :integer
    end
  end

  def self.down
    [:layouts, :snippets, :users].each do |table|
      add_column table, :site_id, :integer
    end
  end
end
