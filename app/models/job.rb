class Job < ActiveRecord::Base
  ### Association

  ### Validate
  validates_presence_of   :title, :description
  validates_uniqueness_of :title
end
