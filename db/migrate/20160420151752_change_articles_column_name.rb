class ChangeArticlesColumnName < ActiveRecord::Migration
  def change
    rename_column :articles, :name, :title
  end
end
