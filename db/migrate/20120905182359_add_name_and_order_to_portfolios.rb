class AddNameAndOrderToPortfolios < ActiveRecord::Migration
  def change
    add_column :portfolios, :name, :string
    add_column :portfolios, :order, :integer
  end
end
