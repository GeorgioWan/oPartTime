class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :title, null: false, default: ""
      t.text :description, null: false, default: ""
      t.string :url, null: false, default: ""
      t.integer :pay, null: false, default: 0
      t.string :location, null: false, default: ""
      t.string :company, null: false, default: ""

      t.timestamps null: false
    end
    add_index :jobs, :title, unique: true
  end
end
