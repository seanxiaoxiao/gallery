class Photo < ActiveRecord::Base
  attr_accessible :desc, :filename, :filepath, :name
end
