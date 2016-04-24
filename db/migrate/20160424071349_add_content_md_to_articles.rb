class AddContentMdToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :content_md, :text
  end
end
