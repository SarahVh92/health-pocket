# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'open-uri'

def grab_image(url, offer)
  downloaded_image = URI.open(url)
  offer.photo.attach(io: downloaded_image, filename: "#{url}.jpg")
end

puts "Cleaning database..."
Offer.destroy_all
User.destroy_all

puts "Creating offers and users..."
User.create!(
  first_name: "Nobuhiko",
  address: "Shibuya, Tokyo",
  last_name: "Sato",
  phone_number: "08033684952"
  #email: "carl@email.com",
  #password: '123456'
)
grab_image("https://res.cloudinary.com/djteaofzf/image/upload/v1675845948/Health-pocket/Profile%20pictures/Screen_Shot_2023-02-08_at_17.36.02_kc2zns.png", User.last)

User.create!(
  first_name: "Marie",
  address: "Arakawa, Tokyo",
  last_name: "De clerck",
  phone_number: "08055684952"
  #email: "marie@email.com",
  #password: '123456'
)
grab_image("https://res.cloudinary.com/djteaofzf/image/upload/v1675846612/Health-pocket/Screen_Shot_2023-02-08_at_17.56.31_kvkxk8.png", User.last)

User.create!(
  first_name: "Ranielle",
  address: "Yokosuka, Kanagawa",
  last_name: "Johnson",
  phone_number: "08055684952"
  #email: "marie@email.com",
  #password: '123456'
)
grab_image("https://res.cloudinary.com/djteaofzf/image/upload/v1675845938/Health-pocket/Profile%20pictures/pexels-rodnae-productions-7467950_ulspsr.jpg", User.last)

Document.create!(
  user: User.all.sample,
  type: "Immunization Record",
  country: "Japan",
  date: "2021/07/12",
  doctor_name: "Kawaguchi, Ryota",
  comment: "2nd COVID buster"
  # picture_url: "v1674729870/Baby Loop/car_e7ztnb.jpg"
)
grab_image("", Offer.last)

Document.create!(
  user: User.all.sample,
  type: "Pathology Records",
  country: "France",
  date: "2023/01/10",
  doctor_name: "Marcel, Vincent",
  comment: "Blood test checking in French"
  # picture_url: "v1674729870/Baby Loop/car_e7ztnb.jpg"
)
grab_image("", Offer.last)

Document.create!(
  user: User.all.sample,
  type: "Referral latter",
  country: "United States of America",
  date: "2022/10/25",
  doctor_name: "Patel, Mittul",
  comment: "Referral later for asma"
  # picture_url: "v1674729870/Baby Loop/car_e7ztnb.jpg"
)
grab_image("", Offer.last)
