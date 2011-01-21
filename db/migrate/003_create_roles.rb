class CreateRoles < ActiveRecord::Migration
  def self.up
    create_table :roles, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
     t.column :name, :string
    end
    Role.create(:name => 'Administrator')
  end

  def self.down
    drop_table :roles
  end
end
