class Photo < ActiveRecord::Base
  attr_accessible :desc, :filename, :filepath, :name
  include Rails.application.routes.url_helpers
  mount_uploader :avatar, AvatarUploader

  #one convenient method to pass jq_upload the necessary information
  def to_jq_upload
    {
        "name" => read_attribute(:avatar),
        "size" => avatar.size,
        "url" => avatar.url,
        "thumbnail_url" => avatar.thumb.url,
        "delete_url" => photo_path(:id => id),
        "delete_type" => "DELETE"
    }
  end

end
