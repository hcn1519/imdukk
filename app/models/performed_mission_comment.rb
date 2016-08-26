class PerformedMissionComment < ActiveRecord::Base
    belongs_to :performed_mission
    belongs_to :user
end
