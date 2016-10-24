module ArticlesHelper
  def simple_content(content)
    content.gsub(/<[^><]*>/, '')[0, 200]
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
    Article.all_tags(admin?)
  end

  #TODO:优化空间
  def page_info articles
    page=params[:page]||1
    page=page.to_i
    admin=admin?
    if params[:tag]
      if admin
        total_size=Article.where('tags LIKE ?', "%#{params[:tag]}%").select do |article|
          article.tags.split(',').include?(params[:tag])
        end.size
      else
        total_size=Article.normal.where('tags LIKE ?', "%#{params[:tag]}%").select do |article|
          article.tags.split(',').include?(params[:tag])
        end.size
      end
    elsif params[:search]
      if admin
        total_size=Article.where('title LIKE ? OR content LIKE ?', "%#{params[:search]}%", "%#{params[:search]}%").size
      else
        total_size=Article.normal.where('title LIKE ? OR content LIKE ?', "%#{params[:search]}%", "%#{params[:search]}%").size
      end
    else
      if admin
        total_size=Article.all.size
      else
        total_size=Article.normal.all.size
      end

    end
    page_info={page_size: Article.page_size, curr_page: page, total_size: total_size}
  end

  def preview?
    request.fullpath.include?('preview')
  end

  def favorite
    Article.favorite(admin?)
  end
end