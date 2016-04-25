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

  def self.all_tags
    tags_hash={}
    tags=Article.all.collect { |article| article.tags }
    tags.each do |tag_string|
      tag_string.split(',').each do |tag|
        if tags_hash[tag].nil?
          tags_hash[tag]=1
        else
          tags_hash[tag]+=1
        end
      end
    end
    tags_arr=tags_hash.sort do |a1, a2|
      a2[1]<=>a1[1]
    end
    tags_arr.to_h
  end

  #TODO:算法待定
  def self.favorite
    Article.take(5)
  end

end