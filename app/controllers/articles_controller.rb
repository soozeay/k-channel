class ArticlesController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  def index
    if params[:plaza_id].present?
      @articles = Article.where(plaza_id: params[:plaza_id]).includes(:user).order('created_at DESC')
    else
      @articles = Article.includes(:user).order('created_at DESC')
    end
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @article.update(article_params)
      redirect_to article_path
    else
      render :edit
    end
  end

  def destroy
    @article.destroy
    redirect_to root_path
  end

  private
  def article_params
    params.require(:article).permit(:title, :text, :ingredients, :trick, :plaza_id, :image).merge(user_id: current_user.id)
  end

  def set_item
    @article = Article.find(params[:id])
  end
end
