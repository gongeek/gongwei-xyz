module ArticlesHelper
  def simple_content(content)
    content.gsub(/<[^>]*>/, '')[0, 200]
  end

  def simple_date(date)
    date.to_s.split(' ')[0]
  end

  def search_params
    params[:search]
  end

  def tag_params
    params[:tag]
  end

  def all_tags
    Article.all_tags
  end

  #TODO:优化空间
  def page_info articles
    page=params[:page]||1
    page=page.to_i
    if params[:tag]
      total_size=Article.where('tags LIKE ?', "%#{params[:tag]}%").select do |article|
        article.tags.split(',').include?(params[:tag])
      end.size
    elsif params[:search]
      total_size=Article.where('title LIKE ? OR content LIKE ?', "%#{params[:search]}%", "%#{params[:search]}%").size
    else
      total_size=Article.all.size
    end
    page_info={page_size: Article.page_size, curr_page: page, total_size: total_size}
  end

  def preview?
    request.fullpath.include?('preview')
  end

  def favorite
    Article.favorite
  end
end