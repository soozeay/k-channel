class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :move_to_index, only: [:edit, :update, :destroy]

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
    @comment = Comment.new
    @comments = @article.comments.includes(:user)
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

  def search
    @articles = Article.search(params[:keyword]).includes(:user).order('created_at DESC')
  end

  private
  def article_params
    params.require(:article).permit(:title, :text, :ingredients, :trick, :plaza_id, :image, :youtube_url).merge(user_id: current_user.id)
  end

  def set_item
    @article = Article.find(params[:id])
  end

  def move_to_index
    redirect_to root_path if @article.user_id != current_user.id
  end
end
