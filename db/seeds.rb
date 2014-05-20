(1..50).each do |i|
  Member.create(name: "Member#{i}", email: "member#{i}@example.com", birthday: "12-01-1989", password: "123456", password_confirmation: "123456", admin: '0')
end

(1..3).each do |i|
  Member.create(name: "Admin#{i}", email: "admin#{i}@example.com", birthday: "12-01-1989", password: "123456", password_confirmation: "123456", admin: '1')
end

(1..5).each do |i|
	Position.create(name: "Position#{i}", name: "PositionName#{i}", short_name: "PN#{i}")
end

(1..3).each do |i|
  Team.create(name: "Team#{i}", description: "join to us", teamleader: "Teamleader#{i}")
  (1..10).each do |j|
    Project.create(name: "project#{j}", shortname: "Pr#{j}", start_date: "01-01-2000", end_date: "01-06-2000", project_leader: "prL#{j}", team_id: i)
   end
end