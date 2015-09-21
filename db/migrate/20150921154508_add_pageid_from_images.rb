class AddPageidFromImages < ActiveRecord::Migration
  def change
    add_column :images, :page_id, :integer
  end
end
