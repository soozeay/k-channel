class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_search

  private
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :age, :gender_id, :country_id, :intro])
    devise_parameter_sanitizer.permit(:account_update, keys: [:nickname, :intro, :cover, :avatar,])
  end

  def set_search
    @search = Article.ransack(params[:q])
    if params[:q].present? #paramsのnil対策
      @search_articles_result = Article.by_any_texts(params[:q][:title_or_user_nickname_cont_all])
    end
  end
  
end
