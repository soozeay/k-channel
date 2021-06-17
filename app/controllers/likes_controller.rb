class LikesController < ApplicationController
  before_action :set_article

  def create
    @like = current_user.likes.create(article_id: params[:article_id])
    redirect_back(fallback_location: root_path)
    flash[:notice] = if I18n.locale.to_s == 'ja'
                       'この記事にいいねしました'
                     else
                       '좋아요 했습니다'
                     end
    @artile = Article.find(params[:article_id])
    @article.create_notification_like!(current_user)
  end

  def destroy
    @like = Like.find_by(article_id: params[:article_id], user_id: current_user.id)
    @like.destroy
    redirect_back(fallback_location: root_path)
    flash[:notice] = if I18n.locale.to_s == 'ja'
                       'この記事のいいねを解除しました'
                     else
                       '좋아요 취소했습니다'
                     end
  end

  private

  def set_article
    @article = Article.find(params[:article_id])
  end
end
