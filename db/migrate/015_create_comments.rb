class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.column :entry_id, :integer
      t.column :user_id, :integer
      t.column :quest_name, :string
      t.column :quest_email, :string
      t.column :quest_url, :string
      t.column :body, :text
      t.column :created_at, :datetime
    end
    add_index :comments, :entry_id
  end

  def self.down
    drop_table :comments
  end
end
