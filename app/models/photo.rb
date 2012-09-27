require 'RMagick'
require 'fileutils'

GRID_THUMBNAIL_HEIGHT = 60
SLIDE_THUMBNAIL_HEIGHT = 100
COVER_THUMBNAIL_WIDTH = 250
COVER_THUMBNAIL_HEIGHT = 250
DEFAULT_HEIGHT = 580

class Photo < ActiveRecord::Base
  include Magick

  belongs_to :album
  belongs_to :slide

  validates :name, :presence => true

  def create_photo(file, desc)
    name = File.basename(file.original_filename, File.extname(file.original_filename))
    self.name = name
    self.desc = desc
    self.save()

    photo_directory = File.join(Rails.root, "public/upload/photo")
    grid_thumbnail_directory = File.join(Rails.root, "public/upload/thumbnail-grid")
    slide_thumbnail_directory = File.join(Rails.root, "public/upload/thumbnail-slide")
    cover_thumbnail_directory = File.join(Rails.root, "public/upload/thumbnail-cover")

    FileUtils.makedirs(photo_directory)
    FileUtils.makedirs(grid_thumbnail_directory)
    FileUtils.makedirs(slide_thumbnail_directory)
    FileUtils.makedirs(cover_thumbnail_directory)

    photo_file_name = self.id.to_s + File.extname(file.original_filename)
    self.filename = photo_file_name
    self.save()

    photo_path = File.join(photo_directory, photo_file_name)
    File.open(photo_path, "wb") { |f| f.write(file.read) }

    grid_thumbnail_file_path = File.join(grid_thumbnail_directory, photo_file_name)
    slide_thumbnail_file_path = File.join(slide_thumbnail_directory, photo_file_name)
    cover_thumbnail_file_path = File.join(cover_thumbnail_directory, photo_file_name)

    img = Image.read(photo_path)[0]
    width = img.columns
    height = img.rows
    if (height > DEFAULT_HEIGHT)
      default_img = img.resize_to_fit(width * DEFAULT_HEIGHT / height , DEFAULT_HEIGHT)
      default_img.write(photo_path)
    end
    grid_thumb = img.resize_to_fit(width * GRID_THUMBNAIL_HEIGHT / height , GRID_THUMBNAIL_HEIGHT)
    slide_thumb = img.resize_to_fit(width * SLIDE_THUMBNAIL_HEIGHT / height , SLIDE_THUMBNAIL_HEIGHT)
    cover_thumb = img.resize_to_fit(width * COVER_THUMBNAIL_HEIGHT / height, COVER_THUMBNAIL_HEIGHT)
    cover_thumb = cover_thumb.crop_resized!(COVER_THUMBNAIL_WIDTH, COVER_THUMBNAIL_HEIGHT, Magick::CenterGravity)

    grid_thumb.write(grid_thumbnail_file_path)
    slide_thumb.write(slide_thumbnail_file_path)
    cover_thumb.write(cover_thumbnail_file_path)

  end

  def photo_path
    return File.join(Rails.root, "public/upload/photo", self.filename)
  end

  def grid_thumbnail_path
    return File.join(Rails.root, "public/upload/thumbnail-grid", self.filename)
  end

  def slide_thumbnail_path
    return File.join(Rails.root, "public/upload/thumbnail-slide", self.filename)
  end

  def cover_thumbnail_path
    return File.join(Rails.root, "public/upload/thumbnail-cover", self.filename)
  end

  def photo_url
    return File.join("/upload/photo", self.filename)
  end

  def grid_thumbnail_url
    return File.join("/upload/thumbnail-grid", self.filename)
  end

  def cover_thumbnail_url
    return File.join("/upload/thumbnail-cover", self.filename)
  end

  def slide_thumbnail_url
    return File.join("/upload/thumbnail-slide", self.filename)
  end

  def delete_url
    return File.join("/photos", self.id.to_s)
  end

  def destroy
    if File.exist?(self.photo_path)
      FileUtils.remove(self.photo_path)
    end
    if File.exist?(self.grid_thumbnail_path)
      FileUtils.remove(self.grid_thumbnail_path)
    end
    if File.exist?(self.slide_thumbnail_path)
      FileUtils.remove(self.slide_thumbnail_path)
    end
    if File.exist?(self.cover_thumbnail_path)
      FileUtils.remove(self.cover_thumbnail_path)
    end
    super
  end

  def upload_response
    return :name => self.filename, :size => File.size(self.photo_path), :url => self.photo_url,
          :thumbnail_url => self.grid_thumbnail_url, :delete_url => self.delete_url, :delete_type => 'DELETE'
  end
end
