class CreateAttachments < ActiveRecord::Migration
  def self.up
    create_table :attachments, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.integer :size
      t.integer :width
      t.integer :height
      t.integer :parent_id
      t.integer :attachable_id
      t.integer :position
      t.string :content_type, :limit => 100
      t.string :filename, :limit => 255
      t.string :path, :limit => 255
      t.string :thumbnail, :limit  => 255
      t.string :attachable_type
      t.timestamps
      t.timestamps      
    end
    add_index :attachments, :parent_id
    add_index :attachments, [:attachable_id, :attachable_type]
  end

  def self.down
    drop_table :attachments
  end
end
