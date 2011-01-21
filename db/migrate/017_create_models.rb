class CreateModels < ActiveRecord::Migration
  def self.up
    create_table :models, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.column :content_type, :string, :null => false
      t.column :filename, :string, :null => false 
      t.column :size, :integer, :null => false
      t.column :db_file_id, :integer
    end
  end

  def self.down
    drop_table :models  
  end
end