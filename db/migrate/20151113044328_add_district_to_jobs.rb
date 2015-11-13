class AddDistrictToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :city,     :string, default: ""
    add_column :jobs, :district, :string, default: ""
  end
end
