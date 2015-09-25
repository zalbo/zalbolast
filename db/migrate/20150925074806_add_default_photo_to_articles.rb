class AddDefaultPhotoToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :default_photo, :integer
  end
end
