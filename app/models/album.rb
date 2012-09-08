class Album < ActiveRecord::Base
  attr_accessible :name
  belongs_to :portfolio
  has_many :photos
end
