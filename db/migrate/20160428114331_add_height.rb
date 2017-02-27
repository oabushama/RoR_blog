class AddHeight < ActiveRecord::Migration
  def change
    add_column :articles, :height, :text
  end
end
