class UsersController < ApplicationController
  before_action :set_user, :set_jobs, except: :favorite
  helper_method :get_location

  def show
  end

  def favorite
    @jobs = []
    if user_signed_in?
      @jobs = current_user.favorite_jobs
    else
      ids = cookies[:favorite_jobs];
      if ids != nil
        @jobs = Job.find(JSON.parse(ids))
      end
    end
    render 'jobs/_jobslist'
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
end
