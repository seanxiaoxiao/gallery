class Portfolio < ActiveRecord::Base
  attr_accessible :name, :order
  has_many :albums
  validates :name, :presence => true
end
