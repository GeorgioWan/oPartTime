class UsersController < ApplicationController
  before_action :set_user, :set_jobs, :set_value, only: :show

  def show
    respond_to do |format|
      format.html
      format.js { render 'jobs/jobslist/loadjobs' }
    end
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def set_jobs
    @jobs = params[:takenoff] ? @user.jobs.where.not( updated_at: (Time.now - 15.days)..Time.now ) : @user.jobs.where( updated_at: (Time.now - 15.days)..Time.now )
    @jobs = @jobs.page(params[:page]).per(20)
    set_jobs_favorite_flag @jobs
  end

  def set_value
    @twitter = @user.twitter.nil? ? "#" : @user.twitter
    @facebook = @user.facebook.nil? ? "#" : @user.facebook
    @googleplus = @user.googleplus.nil? ? "#" : @user.googleplus
    @website = @user.website.nil? ? "#" : @user.website
  end
end
