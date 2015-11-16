class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :guest_name

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
    devise_parameter_sanitizer.for(:account_update ) << :name
  end

  def guest_name
    @name = cookies[:name].nil? ? ["頹廢浪人","絕世美女","武林高手","丐幫成員","神奇寶貝大師","文學青年","小王子"].sample : cookies[:name]
    cookies[:name] = { :value => @name, :expires => 1.minute.from_now }
  end
end
