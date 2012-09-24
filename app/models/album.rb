class Album < ActiveRecord::Base
  attr_accessible :name
  belongs_to :portfolio
  has_many :photos

  validates :name, :presence => true, :uniqueness => true

  def add_photo(photo)
    photo.album = self
    photo.save
  end

  def cover
    return self.photos.length > 0 ? self.photos[0] : nil
  end

  def delete
    self.photos.each do |photo|
      photo.delete
    end
    self.destroy
  end

  def to_response
    return {:id => self.id, :cover_url => self.cover.cover_thumbnail_url}
  end

end
