puts "Seeding data..."

# -----------------------
# Roles
# -----------------------
roles = %w[admin organizer parent student]

roles.each do |name|
  Role.find_or_create_by!(name: name)
end

puts "Roles seeded."

# -----------------------
# Users
# -----------------------
admin = User.find_or_create_by!(email: "admin@example.com") do |u|
  u.first_name = "Admin"
  u.last_name  = "User"
  u.password   = "password"
  u.city       = "Raleigh"
  u.state      = "NC"
  u.zip        = "27601"
end
admin.add_role :admin

organizer1 = User.find_or_create_by!(email: "organizer@example.com") do |u|
  u.first_name = "Olivia"
  u.last_name  = "Organizer"
  u.password   = "password"
  u.city       = "Raleigh"
  u.state      = "NC"
  u.zip        = "27601"
end
organizer1.add_role :organizer

organizer2 = User.find_or_create_by!(email: "organizer2@example.com") do |u|
  u.first_name = "Marcus"
  u.last_name  = "Coach"
  u.password   = "password"
  u.city       = "Raleigh"
  u.state      = "NC"
  u.zip        = "27601"
end
organizer2.add_role :organizer

parent = User.find_or_create_by!(email: "parent@example.com") do |u|
  u.first_name = "Paula"
  u.last_name  = "Parent"
  u.password   = "password"
  u.city       = "Raleigh"
  u.state      = "NC"
  u.zip        = "27601"
end
parent.add_role :parent

student = User.find_or_create_by!(email: "student@example.com") do |u|
  u.first_name = "Sam"
  u.last_name  = "Student"
  u.password   = "password"
  u.city       = "Raleigh"
  u.state      = "NC"
  u.zip        = "27601"
end
student.add_role :student

puts "Users seeded."

# -----------------------
# Events
# -----------------------

events = []

events << Event.find_or_create_by!(title: "Coding Club", user: organizer1) do |e|
  e.description = "Intro to Ruby for beginners."
  e.category = :stem
  e.allowed_gender = :any
  e.rsvp = :public_event
  e.starts_at = 3.days.from_now
  e.registration_deadline = 2.days.from_now
  e.min_age = 10
  e.max_age = 18
  e.max_capacity = 30
  e.location = "Online"
  e.city = nil
  e.state = nil
  e.price = 25


end

events << Event.find_or_create_by!(title: "Soccer Practice", user: organizer1) do |e|
  e.description = "Weekly youth soccer training."
  e.category = :sports
  e.allowed_gender = :any
  e.rsvp = :public_event
  e.starts_at = 1.week.from_now
  e.registration_deadline = 5.days.from_now
  e.min_age = 8
  e.max_age = 14
  e.max_capacity = 22
  e.location = "In-person"
  e.city = "Raleigh"
  e.state = "NC"
  e.price = 45


end

events << Event.find_or_create_by!(title: "Robotics Workshop", user: organizer1) do |e|
  e.description = "Hands-on robotics and STEM learning."
  e.category = :stem
  e.allowed_gender = :any
  e.rsvp = :public_event
  e.starts_at = 5.days.from_now
  e.registration_deadline = 3.days.from_now
  e.min_age = 9
  e.max_age = 15
  e.max_capacity = 20
  e.price = 40

end

events << Event.find_or_create_by!(title: "Creative Art Studio", user: organizer2) do |e|
  e.description = "Painting and mixed media for creative teens."
  e.category = :arts
  e.allowed_gender = :any
  e.rsvp = :public_event
  e.starts_at = 10.days.from_now
  e.registration_deadline = 8.days.from_now
  e.min_age = 12
  e.max_age = 18
  e.max_capacity = 15
  e.location = "Hybrid"
  e.city = "Raleigh"
  e.state = "NC"
  e.price = 25


end

events << Event.find_or_create_by!(title: "Beginner Basketball Clinic", user: organizer2) do |e|
  e.description = "Fundamentals, drills, and teamwork."
  e.category = :sports
  e.allowed_gender = :any
  e.rsvp = :public_event
  e.starts_at = 2.weeks.from_now
  e.registration_deadline = 10.days.from_now
  e.min_age = 8
  e.max_age = 13
  e.max_capacity = 25
  e.location = "In-person"
  e.city = "Durham"
  e.state = "NC"
  e.price = 50


end

events << Event.find_or_create_by!(title: "Guitar Basics for Teens", user: organizer2) do |e|
  e.description = "Learn chords, rhythm, and simple songs."
  e.category = :music
  e.allowed_gender = :any
  e.rsvp = :public_event
  e.starts_at = 12.days.from_now
  e.registration_deadline = 9.days.from_now
  e.min_age = 12
  e.max_age = 18
  e.max_capacity = 12
  e.location = "Hybrid"
  e.city = "Raleigh"
  e.state = "NC"
  e.price = 32

end

events << Event.find_or_create_by!(title: "Homework Help Hour", user: organizer1) do |e|
  e.description = "Drop-in help for math and reading."
  e.category = :tutoring
  e.allowed_gender = :any
  e.rsvp = :public_event
  e.starts_at = 4.days.from_now + 3.hours
  e.registration_deadline = 3.days.from_now
  e.min_age = 8
  e.max_age = 16
  e.max_capacity = 18
  e.location = "Online"
  e.city = nil
  e.state = nil
  e.price = 14


end

events << Event.find_or_create_by!(title: "Chess Club Meetup", user: organizer1) do |e|
  e.description = "Strategy, puzzles, and friendly games."
  e.category = :stem
  e.allowed_gender = :any
  e.rsvp = :public_event
  e.starts_at = 9.days.from_now
  e.registration_deadline = 7.days.from_now
  e.min_age = 10
  e.max_age = 18
  e.max_capacity = 16
end

events << Event.find_or_create_by!(title: "Community Volunteer Day", user: organizer2) do |e|
  e.description = "Light outdoor volunteer work for families."
  e.category = :outdoor
  e.allowed_gender = :any
  e.rsvp = :public_event
  e.starts_at = 3.weeks.from_now
  e.registration_deadline = 2.weeks.from_now
  e.min_age = 10
  e.max_age = 18
  e.max_capacity = 40
end

events << Event.find_or_create_by!(title: "Teen Writing Circle", user: organizer2) do |e|
  e.description = "Creative writing prompts and peer feedback."
  e.category = :arts
  e.allowed_gender = :any
  e.rsvp = :public_event
  e.starts_at = 15.days.from_now
  e.registration_deadline = 12.days.from_now
  e.min_age = 13
  e.max_age = 18
  e.max_capacity = 14
  e.location = "In-person"
  e.city = "Raleigh"
  e.state = "NC"

end

puts "Events seeded (#{events.size})."

Event.find_or_create_by!(title: "Past STEM Workshop", user: organizer1) do |e|
  e.description = "Completed STEM workshop session."
  e.category = :stem
  e.allowed_gender = :any
  e.rsvp = :public_event
  e.starts_at = 5.days.ago
  e.registration_deadline = 7.days.ago
  e.min_age = 10
  e.max_age = 16
  e.max_capacity = 20
end

Event.find_or_create_by!(title: "Past Dance Class", user: organizer2) do |e|
  e.description = "Completed beginner dance session."
  e.category = :dance
  e.allowed_gender = :any
  e.rsvp = :public_event
  e.starts_at = 10.days.ago
  e.registration_deadline = 12.days.ago
  e.min_age = 8
  e.max_age = 14
  e.max_capacity = 18
end

puts "Past events seeded."
almost_full_event = Event.find_or_create_by!(title: "Advanced Coding Bootcamp", user: organizer1) do |e|
  e.description = "Intensive coding workshop for advanced students."
  e.category = :stem
  e.allowed_gender = :any
  e.rsvp = :public_event
  e.starts_at = 6.days.from_now
  e.registration_deadline = 4.days.from_now
  e.min_age = 13
  e.max_age = 18
  e.max_capacity = 30
end

full_event = Event.find_or_create_by!(title: "Weekend Soccer Tournament", user: organizer2) do |e|
  e.description = "Competitive youth soccer tournament."
  e.category = :sports
  e.allowed_gender = :any
  e.rsvp = :public_event
  e.starts_at = 8.days.from_now
  e.registration_deadline = 6.days.from_now
  e.min_age = 10
  e.max_age = 15
  e.max_capacity = 20
end
if defined?(Enrollment)
  # Create 29 enrollments for almost_full_event
  29.times do |i|
    user = User.find_or_create_by!(email: "demo_user_#{i}@example.com") do |u|
      u.first_name = "Demo"
      u.last_name  = "User#{i}"
      u.password   = "password"
      u.city       = "Raleigh"
      u.state      = "NC"
      u.zip        = "27601"
    end

    Enrollment.find_or_create_by!(user: user, event: almost_full_event)
  end

  # Create 20 enrollments for full_event
  20.times do |i|
    user = User.find_or_create_by!(email: "full_user_#{i}@example.com") do |u|
      u.first_name = "Full"
      u.last_name  = "User#{i}"
      u.password   = "password"
      u.city       = "Raleigh"
      u.state      = "NC"
      u.zip        = "27601"
    end

    Enrollment.find_or_create_by!(user: user, event: full_event)
  end

  puts "Capacity demo events seeded."
else
  puts "Enrollment model not found — skipping capacity demo."
end
puts "Attaching demo images..."

demo_images = {
  "Community Volunteer Day" => "community_volunteer.png",
  "Chess Club Meetup" => "chess_club.png",
  "Guitar Basics for Teens" => "guitar_basics.png",
  "Beginner Basketball Clinic" => "basketball_clinic.png",
  "Robotics Workshop" => "robotics_workshop.png",
  "Weekend Soccer Tournament" => "soccer_tournament.png"
}

demo_images.each do |title, filename|
  event = Event.find_by(title: title)
  next unless event

  path = Rails.root.join("db/seed_images", filename)
  unless File.exist?(path)
    puts " - Missing file: #{filename}"
    next
  end

  # избегаем дублирования
  already_attached = event.media_files.any? { |f| f.filename.to_s == filename }
  next if already_attached

  event.media_files.attach(
    io: File.open(path),
    filename: filename,
    content_type: "image/png"
  )

  puts " - Attached #{filename} to #{title}"
end

puts "Demo images attached."

puts "✔ Done."
