class AddUrlToUsers < ActiveRecord::Migration
  def change
    add_column :users, :twitter,    :string
    add_column :users, :facebook,   :string
    add_column :users, :googleplus, :string
    add_column :users, :website,    :string
  end
end
