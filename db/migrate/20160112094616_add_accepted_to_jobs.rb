class AddAcceptedToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :accepted, :string, null: false, default: "wait"
  end
end
