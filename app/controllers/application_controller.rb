class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :basic_auth
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_q_for_article

  private
  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :age, :gender_id, :country_id, :intro])
    devise_parameter_sanitizer.permit(:account_update, keys: [:nickname, :intro, :cover, :avater,])
  end

  def set_q_for_article
    @q = Article.ransack(params[:q])
  end
end
