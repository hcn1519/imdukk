class CreateMissionLikes < ActiveRecord::Migration
  def change
    create_table :mission_likes do |t|
      t.integer :user_id
      t.integer :mission_id
      t.integer :mission_like, default: 0

      t.timestamps null: false
    end
  end
end
