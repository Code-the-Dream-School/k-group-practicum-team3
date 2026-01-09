puts "Seeding data..."

# ---- Roles ----
roles = %w[admin organizer parent student]

roles.each do |name|
  Role.find_or_create_by!(name: name)
end

puts "Roles seeded."

# ---- Users ----
admin = User.find_or_create_by!(email: "admin@example.com") do |u|
  u.first_name = "Admin"
  u.last_name  = "User"
  u.password   = "password"
  u.location_type = :online
end
admin.add_role :admin

organizer = User.find_or_create_by!(email: "organizer@example.com") do |u|
  u.first_name = "Olivia"
  u.last_name  = "Organizer"
  u.password   = "password"
  u.location_type = :in_person
  u.city  = "Raleigh"
  u.state = "NC"
  u.zip   = "27601"
end
organizer.add_role :organizer

student = User.find_or_create_by!(email: "student@example.com") do |u|
  u.first_name = "Sam"
  u.last_name  = "Student"
  u.password   = "password"
  u.location_type = :online
end
student.add_role :student

puts "Users seeded."

# ---- Events (belong to :user) ----
Event.find_or_create_by!(
  title: "Coding Club",
  user: organizer
) do |e|
  e.description   = "Intro to Ruby for beginners."
  e.category      = :stem
  e.allowed_gender = :any
  e.rsvp          = :public_event
  e.starts_at     = 3.days.from_now
  e.min_age       = 10
  e.max_age       = 18
  e.max_capacity  = 30
end

Event.find_or_create_by!(
  title: "Soccer Practice",
  user: organizer
) do |e|
  e.description   = "Weekly youth soccer training."
  e.category      = :sports
  e.allowed_gender = :any
  e.rsvp          = :public_event
  e.starts_at     = 1.week.from_now
  e.min_age       = 8
  e.max_age       = 14
end

puts "Events seeded."

puts "✔ Done."
