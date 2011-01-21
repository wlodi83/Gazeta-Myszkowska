class Comment < ActiveRecord::Base
  belongs_to :entry, :counter_cache => true
  belongs_to :article, :counter_cache => true
  belongs_to :user, :counter_cache => true
  validates_length_of :body, :maximum => 10000
  validates_presence_of :body
end
