class Portfolio < ActiveRecord::Base
  attr_accessible :name, :order
  has_many :albums
  validates :name, :presence => true

  def self.select_options
    self.all.collect {|p| [p.name, p.id]}
  end
end
