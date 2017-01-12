unless User.find_by(email: "foobar@foobar.com")
  User.create(
    email:    "foobar@foobar.com",
    password: "foobar"
  )
end

32.times do |n|
  name = Faker::Company.name + ' ' + Faker::Company.suffix
  description = Faker::Company.catch_phrase + '!'
  address = ""

  address_line = rand(1..146148)
  line_num = 0
  IO.foreach("db/addresses.csv") do |line|
    line_num += 1
    next unless line_num == address_line
    address = line.split(',').join(', ')
    break
  end

  Place.create(
    name:        name,
    address:     address,
    description: description,
    user_id:     User.find_by(email: "foobar@foobar.com").id
  )
end
