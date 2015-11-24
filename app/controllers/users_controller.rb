class UsersController < ApplicationController
  before_action :set_user, :set_jobs, :set_value, only: :show
  helper_method :get_location

  def show
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def set_jobs
    @jobs = @user.jobs.order("updated_at DESC")
  end

  def get_location job
    TaiwanCity.list.each do |c|
      if c[1] == job.city
        @city=c[0]
      end
    end

    TaiwanCity.list(job.city).each do |d|
      if d[1] == job.district
        @district=d[0]
      end
    end

    return "#{@city}#{@district}"
  end

  def set_value
    @twitter = @user.twitter.nil? ? "#" : @user.twitter
    @facebook = @user.facebook.nil? ? "#" : @user.facebook
    @googleplus = @user.googleplus.nil? ? "#" : @user.googleplus
    @website = @user.website.nil? ? "#" : @user.website
  end
end
