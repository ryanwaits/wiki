class ArticlesController < ApplicationController
  before_action :find_article, only: [:show, :edit, :update, :destroy]
  before_action :require_login, only: [:new]

  def index
    if params[:category].blank?
      @articles = Article.all.order('created_at DESC')
    else
      category = Category.find_by(name: params[:category])
      if category
        @articles = Article.where(category_id: category.id)
      else
        @articles = Article.all.order('created_at DESC')
      end
    end
  end

  def show
  end

  def new
    
  end

  def create
    @article = Article.create(article_params)
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
    redirect_to root_path
  end

  private

  def require_login
    unless current_user
      redirect_to root_path
      flash.now.notice = 'You must be logged in'
    end
  end

  def find_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :content, :category_id)
  end
end
