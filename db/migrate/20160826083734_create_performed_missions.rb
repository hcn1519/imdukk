class CreatePerformedMissions < ActiveRecord::Migration
  def change
    create_table :performed_missions do |t|
      
      t.integer :user_id
      t.integer :mission_id
      t.integer :category_id
      t.integer :warning
      
      t.string :title
      t.string :creator_hashtag
      t.string :user_hashtag
      t.text :content
      
      t.timestamps null: false
    end
  end
end
