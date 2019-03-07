puts "destroying all seeds ..."
LocationExcuse.destroy_all
CreativeExcuse.destroy_all
SavedExcuse.destroy_all
User.destroy_all

puts "seeding users ..."
user1 = User.create!(first_name: "Janie", last_name: "Amero", email: 'janie.amero@gmail.com', password: "janieamero")
user2 = User.create!(first_name: 'Maddie', last_name: 'Lewis', email: 'maddie@simplywellbeing.com', password: "maddielewis")
user3 = User.create!(first_name: 'Mark', last_name: 'Gould', email: 'mgould16@gmail.com', password: "mgould16")
user4 = User.create!(first_name: 'Ally', last_name: 'Campbell', email: 'killeralients@outlook.com', password: "killeraliens")

dog = "https://images.pexels.com/photos/356378/pexels-photo-356378.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500"
coffee = "https://images.pexels.com/photos/302899/pexels-photo-302899.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260"
missile = "https://images.pexels.com/photos/76971/fighter-jet-fighter-aircraft-f-16-falcon-aircraft-76971.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260"
time_travel = "https://images.pexels.com/photos/290470/pexels-photo-290470.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260"
nope = "https://images.pexels.com/photos/823301/pexels-photo-823301.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260"
god = "https://images.pexels.com/photos/1485630/pexels-photo-1485630.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260"
croquet = "https://cdn.shopify.com/s/files/1/2217/8163/products/67B4685_copy-sq_1024x1024.jpg?v=1524081406"
body = "https://images.pexels.com/photos/1537174/pexels-photo-1537174.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260"
burn = "https://images.pexels.com/photos/57461/fire-burn-hell-warm-57461.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260"
puts "seeding excuses ..."

excuse1 = LocationExcuse.create!(start_point: "4 Canning Road, London", end_point: "172 Kingsland Road London", lines_disrupted: "Northern Line", disruption_message: "Freezing weather has caused severe delays on the tracks")
LocationExcuse.create!(start_point: "175 Grays Inn Road, London", end_point: "123 Shoreditch High Street", lines_disrupted: "Circle Line", disruption_message: "There has been a fatality on the track")
excuse2 = CreativeExcuse.create!(user: user2, title: "The dog ate my briefcase", description: "She got real hungry and mistook it for her water bowl", category: 'pets') #, remote_photo_url: dog)
excuse3 = CreativeExcuse.create!(user: user1, title: 'The Haddock Flies at midnight', description: "A cryptic clue to keep you guessing", category: 'pets') #, remote_photo_url: coffee)
excuse4 = CreativeExcuse.create!(user: user2, title: 'Had to lose a heat seeking missile first', description: "It followed me from Bombay to Berlin", category: 'pets') #, remote_photo_url: missile)
excuse5 =CreativeExcuse.create!(user: user3, title: "Haven't mastered time travel yet", description: "The death of my close friend, Mr Hawking, has put me back a few hours", category: 'pets') #, remote_photo_url: time_travel)
excuse6 = CreativeExcuse.create!(user: user4, title: 'I am rubber, you are glue', description: "And therefore my lateness has nothing to do with you", category: 'pets') #, remote_photo_url: nope)
excuse7 = CreativeExcuse.create!(user: user1, title: 'I was up all night arguing with my god', description: "It was a battle he didn't let me with nor did he let me lose", category: 'pets') #, remote_photo_url: god)
excuse8 = CreativeExcuse.create!(user: user4, title: 'Croquet Championships', description: "My participation was mandatory as the English #3", category: 'pets') #, remote_photo_url: croquet)
excuse9 = CreativeExcuse.create!(user: user3, title: 'Disposing of body', description: "I didn't know where to put it at first", category: 'pets')#, remote_photo_url: body)
excuse10 = CreativeExcuse.create!(user: user3, title: 'Helping to dispose of body', description: "I had space in the freezer in my shed", category: 'pets') #, remote_photo_url: body)
excuse11 = CreativeExcuse.create!(user: user3, title: 'It burns', description: "He took longer than I thought it would to burn completely", category: 'pets') #, remote_photo_url: burn)
# SavedExcuse.create!(user: user2, excuse: excuse1, message: "How funny is this!", rating: 5)
# SavedExcuse.create!(user: user1, excuse: excuse2, message: "My Daily commute", rating: 5)
# SavedExcuse.create!(user: user1, excuse: excuse3, message: "My Daily commute", rating: 5)
# SavedExcuse.create!(user: user1, excuse: excuse4, message: "My Daily commute", rating: 5)
# SavedExcuse.create!(user: user1, excuse: excuse5, message: "My Daily commute", rating: 5)
# SavedExcuse.create!(user: user1, excuse: excuse6, message: "My Daily commute", rating: 5)
# SavedExcuse.create!(user: user1, excuse: excuse7, message: "My Daily commute", rating: 5)
puts "finished!"
