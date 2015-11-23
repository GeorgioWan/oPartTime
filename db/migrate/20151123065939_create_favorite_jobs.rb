class CreateFavoriteJobs < ActiveRecord::Migration
  def change
    create_table :favorite_jobs do |t|
      t.timestamps null: false
    end
  end
end
