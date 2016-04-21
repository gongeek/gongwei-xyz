class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def new
    @article=Article.new
  end

  def show
    @article=Article.find(params[:id])
  end

  def create
    @article = Article.new(articles_params)
    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: '文章创建成功!' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  private
  def articles_params
    params.require(:article).permit(:title, :tags, :content)
  end

end
