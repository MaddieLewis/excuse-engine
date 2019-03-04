# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
LocationExcuse.destroy_all
CreativeExcuse.destroy_all
SavedExcuse.destroy_all
User.destroy_all


user1 = User.create!(first_name: "Janie", last_name: "Amero", email: 'janie.amero@gmail.com', password: "janieamero")
user2 = User.create!(first_name: 'Maddie', last_name: 'Lewis', email: 'maddie@simplywellbeing.com', password: "maddielewis")
user3 = User.create!(first_name: 'Mark', last_name: 'Gould', email: 'mgould16@gmail.com', password: "mgould16")
user4 = User.create!(first_name: 'Ally', last_name: 'Campbell', email: 'killeralients@outlook.com', password: "killeraliens")

excuse1 = LocationExcuse.create!(start_point: "4 Canning Road, London", end_point: "172 Kingsland Road London", lines_disrupted: "Northern Line", disruption_message: "Freezing weather has caused severe delays on the tracks")
LocationExcuse.create!(start_point: "175 Grays Inn Road, London", end_point: "123 Shoreditch High Street", lines_disrupted: "Circle Line", disruption_message: "There has been a fatality on the track")
excuse2 = CreativeExcuse.create!(user: user2, title: "The dog ate my briefcase", description: "She got real hungry and mistook it for her water bowl", photo: 'https://avatars1.githubusercontent.com/u/34004218?v=4')
CreativeExcuse.create!(user: user1, title: 'The Haddock Flies at midnight', description: "A cryptic clue to keep you guessing", photo: 'https://avatars3.githubusercontent.com/u/43782388?v=4')
SavedExcuse.create!(user: user2, excuse: excuse1, message: "How funny is this!", rating: 5)
SavedExcuse.create!(user: user1, excuse: excuse2, message: "My Daily commute", rating: 5)
