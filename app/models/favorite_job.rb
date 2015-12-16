class FavoriteJob < ActiveRecord::Base
  ### Association
  belongs_to :user
  belongs_to :job
end
