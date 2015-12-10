class FavoriteJobsController < ApplicationController
  
  def add
    if user_signed_in?
      FavoriteJob.find_or_create_by user_id: current_user.id, job_id: params[:jobId]
    end
    render nothing: true
  end
  
  def remove
    if user_signed_in?
      fj = FavoriteJob.find_by user_id: current_user.id, job_id: params[:jobId]
      if fj != nil
        fj.destroy
      end
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
    set_jobs_favorite_flag @jobs
    render 'users/favorite'
  end
end
