class CreateMissionComments < ActiveRecord::Migration
  def change
    create_table :mission_comments do |t|
      
      t.integer :user_id
      t.integer :mission_id

      t.string :mission_comment

      t.timestamps null: false
    end
  end
end
