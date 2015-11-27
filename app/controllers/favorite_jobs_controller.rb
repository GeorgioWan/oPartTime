class FavoriteJobsController < ApplicationController
  
  def add
    if user_signed_in?
      FavoriteJob.find_or_create_by user_id: current_user.id, job_id: params[:jobId]
    end
    render nothing: true
  end
  
  def show
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
end
