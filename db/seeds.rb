# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

for i in 1..6 do
      User.create(
    email: "abc#{i}@test.com",
    password: "123456",
    nickname: "초아쬬아#{i}",
    :profile_img => File.open(File.join(Rails.root, "public/images/choajoa3.png")),
    )
    
    Mission.create(
    user_id: i,
    title: "타이틀#{i}",
    :multimedia => File.open(File.join(Rails.root, "public/images/test#{i}.jpg")),
    content: "#{i}번째 화사의 섹시함은 무무님들 모두 공감하시겠지만, 갠적으로 이번 컨셉 화보로 절정을  찍은 것 같네요. 저 말고 한정판 잡지 겟하신 분~?"
    )
    
  PerformedMission.create(
    user_id: i,
    mission_id: i,
    title: "수행한 미션 타이틀#{i}",
    :multimedia => File.open(File.join(Rails.root, "public/images/test#{i}.jpg")),
    content: "#{i}방탄 오빠들 한 번 그려봤어요!! 이번에 오빠들 컴백한다는 데…벌써 두근거리네요. 금손이신 분들 함께 해요~"
    )  
end
