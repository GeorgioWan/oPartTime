class AddUrlToUsers < ActiveRecord::Migration
  def change
    add_column :users, :twitter,    :string, null: false, default: ""
    add_column :users, :facebook,   :string, null: false, default: ""
    add_column :users, :googleplus, :string, null: false, default: ""
    add_column :users, :website,    :string, null: false, default: ""
  end
end
