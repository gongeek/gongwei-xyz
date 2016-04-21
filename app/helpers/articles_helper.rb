module ArticlesHelper
  def simple_content(content)
    content.gsub(/<[^>]*>/, '')[0, 500]
  end

  def simple_date(date)
    date.to_s.split(' ')[0]
  end
end
