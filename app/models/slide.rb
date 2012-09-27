class Slide < ActiveRecord::Base
  # attr_accessible :title, :body
  has_one :photo, :dependent => :destroy
  accepts_nested_attributes_for :photo, :reject_if => lambda { |p| p.blank? }, :allow_destroy => true

end
