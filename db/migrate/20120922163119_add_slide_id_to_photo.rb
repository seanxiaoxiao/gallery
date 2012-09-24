class AddSlideIdToPhoto < ActiveRecord::Migration
  def change
    add_column :photos, :slide_id, :integer
  end
end
