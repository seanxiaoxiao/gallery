class Portfolio < ActiveRecord::Base
  attr_accessible :name, :order
  has_many :albums, :dependent => :destroy
  validates :name, :presence => true, :uniqueness => true
  accepts_nested_attributes_for :albums, :reject_if => lambda { |albums| albums.blank? }, :allow_destroy => true

  def self.select_options
    self.all.collect {|p| [p.name, p.id]}
  end

end
