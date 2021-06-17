# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  def new_guest
    user = User.guest
    sign_in user
    if I18n.locale.to_s == 'ja'
      redirect_to root_path, notice: 'ゲストユーザーとしてログインしました'
    else
      redirect_to root_path, notice: '게스트 유저로서 로그인했습니다.'
    end
  end

  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
