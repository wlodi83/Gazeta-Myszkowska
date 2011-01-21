class CreateRolesUsersJoin < ActiveRecord::Migration
  def self.up 
    create_table :roles_users, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8', :id => false do |t|
      t.column :role_id, :integer, :null => false
      t.column :user_id, :integer, :null => false
    end
    admin_user = User.create(:username => 'Administrator',
                             :email => 'lwlodarczyk@gazetamyszkowska.pl',
                             :profile => 'Administrator Gazety Myszkowskiej',
                             :password => 'w64121hu', :password_confirmation => 'w64121hu')
    admin_role = Role.find_by_name('Administrator')
    admin_user.roles << admin_role
  end

  def self.down
    drop_table :roles_users
    User.find_by_username('Administrator').destroy
  end
end
