class CreatePhotos < ActiveRecord::Migration
  def self.up
    add_attachment :photos, :image
  end

  def change
    create_table :photos do |t|
      t.string :name
      t.string :image_file_name
      t.timestamps
    end
  end

  def self.down
    remove_attachment :photos, :image
  end
end

