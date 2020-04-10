class ArticlesController < ApplicationController
  before_action :article, :only => [:show, :edit, :update, :destroy]
  before_action :authorize, :except => [:index, :show, :share]

  def index
    page=params[:page]||1
    page=page.to_i
    admin=admin?
    if params[:search]
      @articles = Article.search(params[:search], page, admin)
    elsif params[:tag]
      @articles=Article.filter_tag(params[:tag], page, admin)
    else
      @articles =Article.get_at_page(page, admin)
    end
  end

  def new
    @article=Article.new
  end

  def show
  end

  def share
    @article=Article.find_by_title('share')
    render 'single'
  end

  def about
    @article=Article.find_by_title('about')
    render 'single'
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
      render 'markdown'
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
    @article=Article.temp_article
    render template: "articles/show"
  end

  def preview_post
    # begin
    Article.temp_article=Article.new(articles_params)
    respond_to do |format|
      format.json do
        render json: {ok: true}
      end
    end
    # rescue
    # respond_to do |format|
    #   format.json do
    #     render json: {ok: false}
    #   end
    # end
    # end
  end

  def Article
    Article.unscoped
  end

  private
  def articles_params
    params.require(:article).permit(:title, :tags, :content, :content_md, :secret)
  end

  def article
    @article=Article.find(params[:id])
  end

end
