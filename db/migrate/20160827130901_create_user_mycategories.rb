class CreateUserMycategories < ActiveRecord::Migration
  def change
    create_table :user_mycategories do |t|
      t.integer :user_id
      t.integer :mycategory_id

      t.timestamps null: false
    end
  end
end
