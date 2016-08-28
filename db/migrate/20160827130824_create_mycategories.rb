class CreateMycategories < ActiveRecord::Migration
  def change
    create_table :mycategories do |t|
      t.integer :user_id
      t.integer :category_id
      t.string :name

      t.timestamps null: false
    end
  end
end
