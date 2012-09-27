class Album < ActiveRecord::Base
  attr_accessible :name
  belongs_to :portfolio
  has_many :photos, :dependent => :destroy
  accepts_nested_attributes_for :photos, :reject_if => lambda { |photos| photos.blank? }, :allow_destroy => true

  validates :name, :presence => true, :uniqueness => true

  def add_photo(photo)
    photo.album = self
    photo.save
  end

  def cover
    return self.photos.length > 0 ? self.photos[0] : nil
  end

  def to_response
    return {:id => self.id, :cover_url => self.cover.cover_thumbnail_url}
  end

end
