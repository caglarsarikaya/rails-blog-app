# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Clear existing data
puts "Cleaning database..."
Post.destroy_all
User.destroy_all

# Create sample users
puts "Creating users..."
users = []

10.times do |i|
  name = Faker::Name.name
  email = "user#{i+1}@example.com"
  password = "password123"
  
  user = User.create!(
    name: name,
    email: email,
    password: password,
    password_confirmation: password,
    bio: Faker::Lorem.paragraph(sentence_count: 3)
  )
  
  users << user
  puts "Created user: #{email}"
end

# Create sample blog posts
puts "\nCreating blog posts..."

25.times do |i|
  user = users.sample
  created_at = rand(1..30).days.ago
  
  post = Post.create!(
    title: Faker::Lorem.sentence(word_count: 6, supplemental: true),
    content: [
      Faker::Lorem.paragraph(sentence_count: 8, supplemental: true),
      "## #{Faker::Lorem.sentence(word_count: 4)}\n\n",
      Faker::Lorem.paragraph(sentence_count: 10, supplemental: true),
      "\n### #{Faker::Lorem.sentence(word_count: 3)}\n\n",
      Faker::Lorem.paragraph(sentence_count: 6, supplemental: true),
      "\n> #{Faker::Lorem.paragraph(sentence_count: 2)}\n\n",
      Faker::Lorem.paragraph(sentence_count: 8, supplemental: true)
    ].join("\n\n"),
    user: user,
    created_at: created_at,
    updated_at: created_at
  )
  
  puts "Created post: #{post.title}"
end

puts "\nSeeding completed!"
puts "Created #{User.count} users"
puts "Created #{Post.count} blog posts"
