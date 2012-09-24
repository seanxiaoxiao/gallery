class Slide < ActiveRecord::Base
  # attr_accessible :title, :body
  has_one :photo

  def delete
    self.photo.delete
    self.destroy
  end
end
