class AddCommentsCountToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :comments_count, :integer
  end

  def self.down
    remove_column :users, :comments_count, :integer
  end
end
