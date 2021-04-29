class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :move_to_index, only: [:edit, :update, :destroy]

  def index
    if user_signed_in?
      @tags = Article.tag_counts_on(:tags)
      @page = Article.all.page(params[:page])
      @notifications = current_user.passive_notifications.page(params[:page]).per(20) if user_signed_in?
      @articles_all =Article.includes(:user,:taggings,:likes)

      # トップページの表示切替
      if params[:country_id].present? && params[:plaza_id].present? # 地域別且プラザを選択した場合
        @users = User.where(country_id: params[:country_id])
        @articles = Article.where(user_id: @users.ids, plaza_id: params[:plaza_id]).order('created_at DESC')
      elsif params[:plaza_id].present? # プラザのみ選択した場合
        @articles = Article.where(plaza_id: params[:plaza_id]).includes(:user).order('created_at DESC')
      else # 地域別で全ての投稿を表示したい場合
        @users = User.where(country_id: params[:country_id])
        @articles = Article.where(user_id: @users.ids).order('created_at DESC')
        if @users == []
          # トップページはフォーローユーザーと自身の投稿を表示
          @user = User.find(current_user.id)
          @follow_users = @user.followings
          @articles = @articles_all.where(user_id: @follow_users).or(@articles_all.where(user_id: current_user.id)).order("created_at DESC").page(params[:page]).per(10)
        end
      end
      if @tag = params[:tag]
        @articles = Article.tagged_with(params[:tag]).order('created_at DESC')
      end
    end
  end

  def new
    @article = Article.new
  end

  def create
    @article = current_user.articles.build(article_params)
    if @article.valid?
      @article.save
      return redirect_to root_path
    else
      render :new
    end
  end

  def show
    @comment = Comment.new
    @comments = @article.comments.includes(:user)
    @tags = Article.tag_counts_on(:tags)
    @like = Like.new
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
    params.require(:article).permit(:title, :text, :trick, :plaza_id, :image, :youtube_url, :tag_list).merge(user_id: current_user.id)
  end

  def set_item
    @article = Article.find(params[:id])
  end

  def move_to_index
    redirect_to root_path if @article.user_id != current_user.id
  end
end
