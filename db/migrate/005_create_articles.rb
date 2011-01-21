class CreateArticles < ActiveRecord::Migration
  def self.up
    create_table :articles, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.column :user_id, :integer
      t.column :title, :string
      t.column :synopsis, :text      
      t.column :body, :text
      t.column :published, :boolean, :default => false
      t.column :created_at, :datetime
      t.column :updated_at, :datetime
      t.column :published_at, :datetime
      t.column :category_id, :integer
    end
  end

  def self.down
    drop_table :articles
  end
end
