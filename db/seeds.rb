(1..50).each do |i|
  Member.create(name: "Member#{i}", email: "member#{i}@example.com", birthday: "12-01-1989", password: "123456", password_confirmation: "123456", admin: '0')
end

(1..3).each do |i|
  Member.create(name: "Admin{i}", email: "admin#{i}@example.com", birthday: "12-01-1989", password: "123456", password_confirmation: "123456", admin: '1')
end