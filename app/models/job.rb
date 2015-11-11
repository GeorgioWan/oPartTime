class Job < ActiveRecord::Base
  ### Association
  belongs_to :user

  ### Validate
  validates_presence_of   :title, :description, :pay, :location
  validates_uniqueness_of :title
  validates_length_of     [:title, :company], in: 3..15
  validates_numericality_of :pay, only_integer: true
end
