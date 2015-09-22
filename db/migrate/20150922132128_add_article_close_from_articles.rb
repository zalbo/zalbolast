class AddArticleCloseFromArticles < ActiveRecord::Migration
  def change
    add_column :articles, :article_close, :boolean
  end
end
