class AddSlugToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :slug, :string
    add_index :jobs, :slug, unique: true
  end
end
