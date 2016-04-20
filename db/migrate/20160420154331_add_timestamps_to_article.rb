class AddTimestampsToArticle < ActiveRecord::Migration
  def change
    add_timestamps(:articles)
  end
end
