class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.boolean :default
      t.timestamps null: false
    end
  end
end
