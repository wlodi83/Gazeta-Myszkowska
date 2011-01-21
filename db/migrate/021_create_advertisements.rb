class CreateAdvertisements < ActiveRecord::Migration
  def self.up
    create_table :advertisements, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.string :name, :limit => 200, :null => false 
      t.integer :height
      t.integer :width
      t.string :page, :limit => 100, :null => false
      t.boolean :color, :default => 0
      t.decimal :price, :precision => 8, :scale => 2, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :advertisements
  end
end
