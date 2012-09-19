class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :name
      t.string :filename
      t.string :desc
      t.string :filepath

      t.timestamps
    end
  end
end
