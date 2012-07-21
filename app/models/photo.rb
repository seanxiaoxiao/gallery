class Photo < ActiveRecord::Base
  attr_accessible :image_file_name, :name, :image
  has_attached_file :image
end
