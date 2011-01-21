class AddCommentsCountToArticles < ActiveRecord::Migration
  def self.up
    add_column :articles, :comments_count, :integer
  end

  def self.down
    remove_column :articles, :comments_count
  end
end
