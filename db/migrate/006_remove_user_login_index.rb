class RemoveUserLoginIndex < ActiveRecord::Migration[5.1]
  def self.up
    remove_index "users", :name => "login"
  end
  
  def self.down
  end
end
