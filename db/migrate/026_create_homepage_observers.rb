class CreateHomepageObservers < ActiveRecord::Migration
  def self.up
    create_table :homepage_observers do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :homepage_observers
  end
end
