class FavoriteJobsController < ApplicationController
  before_action :set_jobs, only: :show

  def show
    respond_to do |format|
      format.html { render 'users/favorite' }
      format.js { render 'jobs/jobslist/loadjobs' }
    end
  end

  def create
    if user_signed_in?
      FavoriteJob.find_or_create_by user_id: current_user.id, job_id: params[:jobId]
    end
    render nothing: true
  end

  def destroy
    if user_signed_in?
      fj = FavoriteJob.find_by user_id: current_user.id, job_id: params[:jobId]
      if fj != nil
        fj.destroy
      end
    end
    render nothing: true
  end

  private
  def set_jobs
    @jobs = []
    if user_signed_in?
      @jobs = current_user.favorite_jobs
    else
      ids = cookies[:favorite_jobs];
      if ids != nil
        @jobs = Job.find(JSON.parse(ids))
      end
    end

    # handle Kaminari paginate array
    @jobs = Kaminari.paginate_array(@jobs).page(params[:page]).per(20)
    set_jobs_favorite_flag @jobs
  end
end
