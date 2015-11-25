class FavoriteJobsController < ApplicationController
  def add
    if user_signed_in?
      FavoriteJob.find_or_create_by user_id: current_user.id, job_id: params[:jobId]
    end
    render nothing: true
  end
end
