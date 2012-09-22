class Slide < ActiveRecord::Base
  # attr_accessible :title, :body
  has_one :photo
end
