class AddColumnFromPages < ActiveRecord::Migration
  def change
    add_column :pages, :title, :string
    add_column :pages, :content, :string
  end
end
