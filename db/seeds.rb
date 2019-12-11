Singer.create! name: "Rhymastic", description: FFaker::Lorem.sentence(5)

Singer.create! name: "JSOL", description: FFaker::Lorem.sentence(5)

Singer.create! name: "JustaTee", description: FFaker::Lorem.sentence(5)

Singer.create! name: "Magazine", description: FFaker::Lorem.sentence(5)

Singer.create! name: "The Men", description: FFaker::Lorem.sentence(5)

Singer.create! name: "Andiez", description: FFaker::Lorem.sentence(5)

Singer.create! name: "Other", description: FFaker::Lorem.sentence(5)

User.create! name: "ADMIN", password: "123456", email: "admin@gmail.com", role: 1

User.create! name: "User1", password: "123456", email: "user1@gmail.com", role: 0
