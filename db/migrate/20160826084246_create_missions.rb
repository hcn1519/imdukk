class CreateMissions < ActiveRecord::Migration
  def change
    create_table :missions do |t|
      t.integer :user_id
      t.integer :category_id
      t.integer :warning
      
      t.string :title
      t.string :multimedia
      t.text :content
      
      t.integer :mission_like_count, default: 0
      t.integer :mission_comment_count, default: 0
      t.timestamps null: false
    end
  end
end
