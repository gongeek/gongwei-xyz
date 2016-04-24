class Article < ActiveRecord::Base
  @@temp_article
  attr_accessor :temp_article

  class << self
    attr_accessor :temp_article
  end

  def self.search(search, page)
    where('title LIKE ? OR content LIKE ?', "%#{search}%", "%#{search}%").order("created_at DESC").limit(page_size).offset((page-1)*page_size)
  end

  def self.filter_tag(tag, page)
    articles=where('tags LIKE ?', "%#{tag}%").order("created_at DESC").select do |article|
      article.tags.split(',').include?(tag)
    end
    articles_page_arr=articles.each_slice(page_size).to_a
    articles_page_arr[page-1]
  end

  def self.get_at_page(page)
    Article.all.order('created_at DESC').limit(page_size).offset((page-1)*page_size)
  end

  def self.page_size
    5
  end

end