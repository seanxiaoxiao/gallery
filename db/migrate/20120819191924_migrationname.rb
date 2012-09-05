class Migrationname < ActiveRecord::Migration
  def up
    remove_column :photos, :created
  end

  def down
  end
end
