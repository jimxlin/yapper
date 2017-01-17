# *Important* seeding will add images
#   to root/public/uploads/photo/picture (for local storage)
#   or to whatever cloud storage you are using.
#   It is recommended to delete these images before a re-seed.

# Clear DB entries
Place.delete_all
User.delete_all
Comment.delete_all
Photo.delete_all

############################ Users #####################################

8.times do |n|
  User.create!(
    email:    "foobar-#{n}@foobar.com",
    password: "foobar"
  )
end

user_ids = []
User.find_each { |user| user_ids << user.id }

############################ Places ####################################

32.times do
  name = Faker::Company.name + ' ' +Faker::Commerce.department(1)
  description = Faker::Company.catch_phrase + '! We ' + Faker::Company.bs + '!'
  address = ""

  address_line = rand(1..146148)
  line_num = 0
  IO.foreach("db/seed_data/addresses.csv") do |line|
    line_num += 1
    next unless line_num == address_line
    address = line.split(',').join(', ')
    break
  end

  Place.create!(
    name:        name,
    address:     address,
    description: description,
    user_id:     user_ids.sample
  )
end

place_ids = []
Place.find_each { |place| place_ids << place.id }

############################ Comments ##################################

Comment.skip_callback(:create, :after, :send_comment_email)

128.times do
  message = Faker::Hipster.paragraph(2, false, 1)
  rating = Comment::RATINGS[Comment::RATINGS.keys.sample]
  place_id = place_ids.sample
  user_id = user_ids.sample

  Comment.create!(
    message:  message,
    rating:   rating,
    place_id: place_id,
    user_id:  user_id
  )
end

Comment.set_callback(:create, :after, :send_comment_email)

############################## Photos ##################################

IMG_PATHS = {
  img1: "db/seed_data/salad01.jpg",
  img2: "db/seed_data/salad02.jpg",
  img3: "db/seed_data/salad03.jpg",
  img4: "db/seed_data/salad04.jpg",
  img5: "db/seed_data/salad05.jpg",
  img6: "db/seed_data/salad06.jpg",
  img7: "db/seed_data/salad07.jpg",
  img8: "db/seed_data/salad08.jpg",
  img9: "db/seed_data/salad09.jpg",
  img10: "db/seed_data/salad10.jpg",
  img11: "db/seed_data/salad11.jpg"
}

64.times do
  img_path = IMG_PATHS[IMG_PATHS.keys.sample]
  caption = Faker::Hipster.sentence(2, false, 1)
  place_id = place_ids.sample

  Photo.create(
    picture:  Rails.root.join(img_path).open,
    caption:  caption,
    place_id: place_id
  )
end
