class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  def after_sign_in_path_for(resource)
    root_path(resource.id)
  end

  private

  def sign_in_required
      redirect_to new_user_session_url, notice: 'ログインされていません' unless user_signed_in?
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email])
    devise_parameter_sanitizer.permit(:sign_up, keys: [profile_attributes: [:image, :image_cache] ])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :email])
  end
  
end
