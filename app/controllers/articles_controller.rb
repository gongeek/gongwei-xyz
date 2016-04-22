class ArticlesController < ApplicationController
  before_action :article, :only => [:show, :edit, :update, :destroy]
  before_action :authorize, :except => [:index, :show]

  def index
    @articles = Article.all
  end

  def new
    @article=Article.new
  end

  def show
  end

  def create
    @article = Article.new(articles_params)
    respond_to do |format|
      if @article.save
        redirect_to @article, notice: '文章创建成功!'
      else
        render 'new'
      end
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

  private
  def articles_params
    params.require(:article).permit(:title, :tags, :content)
  end

  def article
    @article=Article.find(params[:id])
  end

end
