class CreateDbFiles < ActiveRecord::Migration
 def self.up
    create_table :db_files, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.column :data, :binary, :null => :false
    end
    execute "ALTER TABLE db_files MODIFY data LONGBLOB NOT NULL"
  end

  def self.down
    drop_table :db_files  
  end
end
