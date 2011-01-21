class Attachment < ActiveRecord::Base
  belongs_to :attachable, :polymorphic => true
  has_attachment :storage => :file_system,
                 :path_prefix => 'public/files',
                 :resize_to => '640x480',
                 :thumbnails => { :main => [350, 219], :right_thumb => [100, 63], :list_articles => [150, 94], :thumb => '120x80', :window => '80>', :tiny => '50>'},
                 :max_size => 5.megabytes,
                 :content_type => :image,
                 :processor => 'Rmagick'
end