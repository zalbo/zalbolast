class AddUrlYoutubeToPages < ActiveRecord::Migration
  def change
    add_column :pages, :url_youtube, :text
  end
end
