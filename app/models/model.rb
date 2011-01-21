class Model < ActiveRecord::Base

belongs_to :db_files
  
has_attachment :content_type => 'application/pdf',
                :storage => :db_file,
                :size => 0.megabyte..25.megabytes
validates_as_attachment
end
