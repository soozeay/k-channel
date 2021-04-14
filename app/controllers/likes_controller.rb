class LikesController < ApplicationController
  def create
    @like = current_user.likes.create(article_id: params[:article_id])
    redirect_back(fallback_location: root_path)
    @artile = Article.find(params[:article_id])
    @article.create_notification_like!(current_user)
  end

  def destroy
    @like = Like.find_by(article_id: params[:article_id], user_id: current_user.id)
    @like.destroy
    redirect_back(fallback_location: root_path)
  end
end
