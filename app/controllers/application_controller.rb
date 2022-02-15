class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:top, :about] #2022/2/15(debug)
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def after_sign_in_path_for(resource)
    # root_path
    user_path(current_user) #2022/2/16(debug)
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end
end
