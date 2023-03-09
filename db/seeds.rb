# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'open-uri'

def grab_image(url, instance)
  downloaded_image = URI.open(url)
  instance.photo.attach(io: downloaded_image, filename: "#{url}.jpg", content_type: "image/png")
end

puts "Cleaning database..."
User.destroy_all
puts "Users deleted"
Document.destroy_all
puts "Documents deleted"

puts "\ncreating users..."
user1 = User.create!(
  first_name: "Nobuhiko",
  address: "Shibuya, Tokyo",
  last_name: "Sato",
  phone_number: "08033684952",
  email: "nobusato@email.com",
  password: '123456'
)
grab_image("https://res.cloudinary.com/djteaofzf/image/upload/v1675845948/Health-pocket/Profile%20pictures/Screen_Shot_2023-02-08_at_17.36.02_kc2zns.png", User.last)
puts "#{user1.first_name} is created"

user2 = User.create!(
  first_name: "Marie",
  address: "Arakawa, Tokyo",
  last_name: "De Clerck",
  phone_number: "08055684952",
  email: "marie@email.com",
  password: '123456'
)
grab_image("https://res.cloudinary.com/djteaofzf/image/upload/v1675846612/Health-pocket/Screen_Shot_2023-02-08_at_17.56.31_kvkxk8.png", User.last)
puts "#{user2.first_name} is created"

user3 = User.create!(
  first_name: "Ranielle",
  address: "Yokosuka, Kanagawa",
  last_name: "Johnson",
  phone_number: "08055684952",
  email: "ranielle@email.com",
  password: '123456'
)
grab_image("https://res.cloudinary.com/djteaofzf/image/upload/v1675845938/Health-pocket/Profile%20pictures/pexels-rodnae-productions-7467950_ulspsr.jpg", User.last)
puts "#{user3.first_name} is created"

puts "\ncreating documents..."
document1 = Document.create!(
  user: User.all.sample,
  doc_type: "Immunization Records",
  country: "Japan",
  date: Date.parse("2021/07/12"),
  doctor_name: "Kawaguchi Ryota",
  comment: "2nd COVID booster"
  # picture_url: "v1674729870/Baby Loop/car_e7ztnb.jpg"
)
grab_image("https://res.cloudinary.com/djteaofzf/image/upload/v1675943448/Health-pocket/Screen_Shot_2023-02-09_at_20.45.45_t1aqhk.png", Document.last)
puts "Document 1 is created"

document2 = Document.create!(
  user: User.all.sample,
  doc_type: "Pathology Records",
  country: "France",
  date: Date.parse("2023/01/10"),
  doctor_name: "Marcel Vincent",
  comment: "Blood test in French"
  # picture_url: "v1674729870/Baby Loop/car_e7ztnb.jpg"
)
grab_image("https://res.cloudinary.com/djteaofzf/image/upload/v1675943804/Health-pocket/Screen_Shot_2023-02-09_at_20.55.54_hulxek.png", Document.last)
puts "Document 2 is created"

document3 = Document.create!(
  user: User.all.sample,
  doc_type: "Referral Letters",
  country: "USA",
  date: Date.parse("2022/10/25"),
  doctor_name: "Ella Jackson",
  comment: "Migraine"
  # picture_url: "v1674729870/Baby Loop/car_e7ztnb.jpg"
)
grab_image("https://res.cloudinary.com/djteaofzf/image/upload/v1675943445/Health-pocket/Referral_letter_hwohzn.png", Document.last)
puts "Document 3 is created"
