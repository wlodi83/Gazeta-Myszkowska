class Article < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  has_many :comments
  belongs_to :community
  is_indexed :fields => [:title, :body], :conditions => "published = #{true}"
  has_many :attachments, :as => :attachable, :dependent => :destroy 
  before_save :updated_published_at
  def updated_published_at
    self.published_at = Time.now if published == true
  end
  
  validates_presence_of :title, :synopsis, :body, :title
  validates_length_of :title, :maximum => 255
  validates_length_of :synopsis, :maximum => 10000
  validates_length_of :body, :maximum => 2000000
  
end
