class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_account_update_params, only: [:update]
  before_action :ensure_normal_user, only: :destroy

  protected
  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  def after_update_path_for(_resource)
    user_path(current_user.id)
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  end

  def ensure_normal_user
    if resource.email == 'guest@example.com'
      if I18n.locale.to_s == "ja"
        redirect_to root_path, alert: 'ゲストユーザーは削除できません。'
      else
        redirect_to root_path, alert: '게스트 유저는 삭제할 수 없습니다.'
      end
    end
  end
end