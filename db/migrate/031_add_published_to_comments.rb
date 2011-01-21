class AddPublishedToComments < ActiveRecord::Migration
  def self.up
    add_column :comments, :published, :boolean, :default => false
  end

  def self.down
    remove_column :comments, :published
  end
end
