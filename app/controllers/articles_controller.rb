class ArticlesController < ApplicationController

  before_action :authenticate_user!, except: [:show, :index]
  before_action :set_article, except: [:index, :new, :create]

  # GET /articles
  # Todos os registros
  def index
    @articles = Article.all
  end

  # GET /articles/:id
  # Encontra um registro por id
  def show
    @article.update_visits_count
    @comment = Comment.new
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # POST /articles
  def create
    # @article = Article.new(params[:article])
    # @article = Article.new(article_params)
    
    @article = current_user.articles.new(article_params)

    if @article.save
      redirect_to @article
    else
      render :new
    end  
  end

  def edit

  end

  def update
    
    if @article.update(article_params)
      redirect_to @article
    else
      render :edit
    end    
  end

  def destroy
    @article.destroy
    redirect_to articles_path
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :body)
  end  

end
