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
    @jobs = params[:takenoff] ? 
            @user.jobs.where( "jobs.accepted != ? or jobs.updated_at < ? ", 'pass', 15.days.ago ) # 未上架 = 審核未通過 or 上架超過15日者
            : 
            @user.jobs.where( accepted: 'pass', updated_at: 15.days.ago..Time.now ) # 上架 = 審核通過 + 15日內審核通過者
            
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
