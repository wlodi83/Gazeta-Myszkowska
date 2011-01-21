class Category < ActiveRecord::Base
  has_many :articles, :dependent => :nullify
  belongs_to :community
  validates_length_of :name, :maximum => 80 
  acts_as_tree :order => "name"
 
    def self.find_through_tree
        find_root.collect { |category| category.self_with_children }.flatten
    end
  
    def self.find_root
        Category.find_all_by_parent_id(nil) # may need to adjust this
    end
  
    def self_with_children
        [self] + children.collect { |category| category.self_with_children }
    end
  
    def indented_name
        ("-" * ancestors.size) + name
    end  

end
