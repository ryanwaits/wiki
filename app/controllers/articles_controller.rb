class ArticlesController < ApplicationController
  before_action :find_article, only: [:show, :edit, :update, :destroy]

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

  private

  def find_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :content, :category_id)
  end
end
