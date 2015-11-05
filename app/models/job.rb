class Job < ActiveRecord::Base
  ### Association
  belongs_to :user

  ### Validate
  validates_presence_of   :title, :description
  validates_uniqueness_of :title
end
