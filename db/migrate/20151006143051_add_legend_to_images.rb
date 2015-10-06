class AddLegendToImages < ActiveRecord::Migration
  def change
    add_column :images, :legend, :string
  end
end
