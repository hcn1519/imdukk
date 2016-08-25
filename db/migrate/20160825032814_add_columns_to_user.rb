class AddColumnsToUser < ActiveRecord::Migration
  def change
    add_column :users, :nickname, :string
    add_column :users, :profile_img, :string
    add_column :users, :profile_background_img, :string
    add_column :users, :duck_img, :string
  end
end
