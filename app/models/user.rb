class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ### Association
  has_many :jobs
  has_many :favorite_job_list, class_name: "FavoriteJob"
  has_many :favorite_jobs, through: :favorite_job_list, source: :job
end
