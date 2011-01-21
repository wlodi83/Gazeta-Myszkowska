class UpdateCommentsTable < ActiveRecord::Migration
  def self.up
    remove_column :comments, :quest_name
    remove_column :comments, :quest_email
    remove_column :comments, :quest_url
  end

  def self.down
    add_column :comments, :quest_name
    add_column :comments, :quest_email
    add_column :comments, :quest_url
  end
end
