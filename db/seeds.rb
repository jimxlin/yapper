32.times do |n|
  name = Faker::Company.name + ' ' + Faker::Company.suffix
  description = Faker::Company.catch_phrase + '!'
  address = [Faker::Address.street_address + ' ' + Faker::Address.street_suffix,
             Faker::Address.city,
             Faker::Address.state_abbr + ' ' + Faker::Address.zip].join(', ')
  Place.create(name: name, address: address, description: description)
end
