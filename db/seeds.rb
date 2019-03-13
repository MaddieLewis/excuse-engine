puts "destroying all seeds ..."
LocationExcuse.destroy_all
CreativeExcuse.destroy_all
SavedExcuse.destroy_all
User.destroy_all

puts "seeding users ..."
user1 = User.create!(first_name: "Janie", last_name: "Amero", username: 'jamero', email: 'janie.amero@gmail.com', password: "janieamero")
user2 = User.create!(first_name: 'Maddie', last_name: 'Lewis', username: 'mlewis', email: 'maddie@simplywellbeing.com', password: "maddielewis")
user3 = User.create!(first_name: 'Mark', last_name: 'Gould', username: 'mgould', email: 'mark.gould16@gmail.com', password: "mgould16")
user4 = User.create!(first_name: 'Ally', last_name: 'Campbell', username: 'acampbell', email: 'killeralients@outlook.com', password: "killeraliens")

puts "seeding excuses ..."

excuse1 = LocationExcuse.create!(start_point: "4 Canning Road, London", end_point: "172 Kingsland Road London", lines_disrupted: "Northern Line", disruption_message: "Freezing weather has caused severe delays on the tracks")
LocationExcuse.create!(start_point: "175 Grays Inn Road, London", end_point: "123 Shoreditch High Street", lines_disrupted: "Circle Line", disruption_message: "There has been a fatality on the track")
excuse2 = CreativeExcuse.create!(user: user2, title: "The dog ate my briefcase", description: "She got real hungry and mistook it for her water bowl", category: "family" )
excuse3 = CreativeExcuse.create!(user: user1, title: 'The Haddock Flies at midnight', description: "A cryptic clue to keep you guessing", category: "other")
excuse4 = CreativeExcuse.create!(user: user2, title: 'Had to lose a heat seeking missile first', description: "It followed me from Bombay to Berlin", category: "travel" )
excuse5 =CreativeExcuse.create!(user: user3, title: "Haven't mastered time travel yet", description: "The death of my close friend, Mr Hawking, has put me back a few hours", category: "family" )
excuse6 = CreativeExcuse.create!(user: user4, title: 'I am rubber, you are glue', description: "And therefore my lateness has nothing to do with you", category: "funny" )
excuse7 = CreativeExcuse.create!(user: user1, title: 'I was up all night arguing with my god', description: "It was a battle he didn't let me with nor did he let me lose", category: "life")
excuse8 = CreativeExcuse.create!(user: user4, title: 'Croquet Championships', description: "My participation was mandatory as the English #3", category: "life")
excuse9 = CreativeExcuse.create!(user: user3, title: 'Disposing of body', description: "I didn't know where to put it at first", category: "family")
excuse10 = CreativeExcuse.create!(user: user3, title: 'Helping to dispose of body', description: "I had space in the freezer in my shed", category: "other" )
excuse11 = CreativeExcuse.create!(user: user3, title: 'It burns', description: "He took longer than I thought it would to burn completely", category: "other" )
excuse12 = CreativeExcuse.create!(user: user1, title: 'Hot Air Balloon Issues', description: "I was hot air ballooning it and the wind changed direction", category: "travel" )
excuse13 = CreativeExcuse.create!(user: user2, title: 'My escalator broke', description: "I was on an escalator and it got stuck when i was half way up", category: "funny" )
excuse14 = CreativeExcuse.create!(user: user4, title: 'Wolves', description: "I got ravaged by wolves", category: "funny" )
excuse15 = CreativeExcuse.create!(user: user1, title: 'Azkaban', description: "I had to escape Azkaban first", category: "funny" )
excuse16 = CreativeExcuse.create!(user: user2, title: 'Rick Astley', description: "I was given up and let down by Mr Astley", category: "life" )
excuse17 = CreativeExcuse.create!(user: user2, title: 'Parade Issues', description: "I got caught in a parade", category: "travel" )

# puts "seeding reports ..."

# require "Date"
# excuse18 = ReportedExcuse.create!(user: user1, title: "In Hounslow", description: "Long delays on train", address: "4 Canning Road", latitude: "51.509865", longitude: "-0.118092", category: "time constraint", time: DateTime.now )

# SavedExcuse.create!(user: user2, excuse: excuse1, message: "How funny is this!", rating: 5)
# SavedExcuse.create!(user: user1, excuse: excuse2, message: "My Daily commute", rating: 5)
# SavedExcuse.create!(user: user1, excuse: excuse3, message: "My Daily commute", rating: 5)
# SavedExcuse.create!(user: user1, excuse: excuse4, message: "My Daily commute", rating: 5)
# SavedExcuse.create!(user: user1, excuse: excuse5, message: "My Daily commute", rating: 5)
# SavedExcuse.create!(user: user1, excuse: excuse6, message: "My Daily commute", rating: 5)
# SavedExcuse.create!(user: user1, excuse: excuse7, message: "My Daily commute", rating: 5)
puts "finished!"
