class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :name
      t.integer :portfolio_id


      t.timestamps
    end

    add_index :albums, [:portfolio_id]

  end
end
