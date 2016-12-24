class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  # before_action :authenticate_user! , :unless => :devise_controller?
  before_action :load_filter

  def load_filter
    if params[:key].present?
      authenticate_user_from_token!
    else
      authenticate_user!
    end
  end

  def after_sign_up_path_for(resource)
    if resource.admin == true
      users_path
    else
      root_path
    end
  end

  def after_sign_in_path_for(resource)
    if resource.admin == true
      users_path
    else
      root_path
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :first_name, :last_name, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:email, :password)}
    devise_parameter_sanitizer.for(:account_update){|u| u.permit(:email, :first_name, :last_name)}#, keys: [:email, :first_name, :last_name]
  end

end
