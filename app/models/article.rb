class Article < ActiveRecord::Base
  @@temp_article
  attr_accessor :temp_article
  scope :normal, -> { where(secret: false) }

  class << self
    attr_accessor :temp_article
  end

  def self.search(search, page, admin)
    if admin
      Article.where('title LIKE ? OR content LIKE ?', "%#{search}%", "%#{search}%").order("created_at DESC").limit(page_size).offset((page-1)*page_size)
    else
      Article.normal.where('title LIKE ? OR content LIKE ?', "%#{search}%", "%#{search}%").order("created_at DESC").limit(page_size).offset((page-1)*page_size)
    end
  end

  def self.filter_tag(tag, page, admin)
    if admin
      articles=where('tags LIKE ?', "%#{tag}%").order("created_at DESC").select do |article|
        article.tags.split(',').include?(tag)
      end
    else
      articles=Article.normal.where('tags LIKE ?', "%#{tag}%").order("created_at DESC").select do |article|
        article.tags.split(',').include?(tag)
      end
    end
    articles_page_arr=articles.each_slice(page_size).to_a
    articles_page_arr[page-1]
  end

  def self.get_at_page(page, admin)
    if admin
      Article.all.order('created_at DESC').limit(page_size).offset((page-1)*page_size)
    else
      Article.normal.all.order('created_at DESC').limit(page_size).offset((page-1)*page_size)
    end

  end

  def self.page_size
    5
  end

  def self.all_tags(admin)

    tags_hash={}
    if admin
      tags=Article.all.collect { |article| article.tags }
    else
      tags=Article.normal.all.collect { |article| article.tags }
    end

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
  def self.favorite(admin)
    if admin
      Article.take(5)
    else
      Article.normal.take(5)
    end

  end

end