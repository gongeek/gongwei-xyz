class ArticlesController < ApplicationController
  before_action :article, :only => [:show, :edit, :update, :destroy]
  before_action :authorize, :except => [:index, :show]

  def index
    page=params[:page]||1
    page=page.to_i
    if params[:search]
      @articles = Article.search(params[:search], page)
    elsif params[:tag]
      @articles=Article.filter_tag(params[:tag], page)
    else
      @articles =Article.get_at_page(page)
    end
  end

  def new
    @article=Article.new
  end

  def show
  end

  def create
    @article = Article.new(articles_params)
    if @article.save
      redirect_to @article, notice: '文章创建成功!'
    else
      render 'new'
    end
  end

  def edit
  end


  def update
    if @article.update(articles_params)
      redirect_to @article, notice: '文章编辑成功!'
    else
      render 'edit'
    end
  end

  def destroy
    if @article.destroy
      redirect_to articles_path
    else
      redirect_to article_path(@article)
    end
  end

  def preview

  end

  def preview_post
    begin
      Article.temp_article=Article.new(articles_params)
      respond_to do |format|
        format.json do
          render json: {ok: true}
        end
      end
    rescue
      respond_to do |format|
        format.json do
          render json: {ok: false}
        end
      end
    end
  end

  private
  def articles_params
    params.require(:article).permit(:title, :tags, :content, :content_md)
  end

  def article
    @article=Article.find(params[:id])
  end

end
