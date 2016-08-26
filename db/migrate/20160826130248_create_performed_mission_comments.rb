class CreatePerformedMissionComments < ActiveRecord::Migration
  def change
    create_table :performed_mission_comments do |t|
      
      t.integer :user_id
      t.integer :performed_mission_id

      t.string :performed_mission_comment

      t.timestamps null: false
    end
  end
end
