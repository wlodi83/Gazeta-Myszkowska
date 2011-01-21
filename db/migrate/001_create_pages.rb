class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
     t.column :title, :string
     t.column :permalink, :string
     t.column :body, :text
     t.column :created_at, :datetime
     t.column :updated_at, :datetime
     end
    
   Page.create(:title => "Gazeta Myszkowska",
                 :permalink => "welcome-page",
                 :body => "Strona Gazety Myszkowskiej") 
  end

  def self.down
    drop_table :pages
  end
end
