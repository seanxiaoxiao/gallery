class AddCoverIdToAlbum < ActiveRecord::Migration
  def change
    add_column :albums, :cover_id, :integer
  end
end
