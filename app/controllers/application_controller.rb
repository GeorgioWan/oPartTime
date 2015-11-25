class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :guest_name, :set_login_cookie
  before_action :merge_favorite_job_from_cookie, if: :user_signed_in?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
    devise_parameter_sanitizer.for(:account_update ) << :name
  end

  def guest_name
    @name = cookies[:name].nil? ? ["頹廢浪人","絕世美女","武林高手","丐幫成員","神奇寶貝大師","文學青年","小王子"].sample : cookies[:name]
    cookies[:name] = { :value => @name, :expires => 1.minute.from_now }
  end

  def set_login_cookie
    cookies[:is_login] = user_signed_in?
  end

  def merge_favorite_job_from_cookie
    jobIds = cookies[:favorite_jobs]
    if jobIds != nil
      JSON.parse(jobIds).each do |id|
        FavoriteJob.find_or_create_by user_id: current_user.id, job_id: id
      end
    end
    cookies.delete :favorite_jobs
  end
end
