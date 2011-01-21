class CreateAdvertModules < ActiveRecord::Migration
  def self.up
    create_table :advert_modules, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.string :name, :limit => 200, :null => false 
      t.timestamps
    end
  end

  def self.down
    drop_table :advert_modules
  end
end
