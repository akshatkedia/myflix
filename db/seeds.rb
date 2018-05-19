# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Category.create name: 'Comedy'
Category.create name: 'Drama'

Video.create(
  title: 'Family Guy',
  description: 'Peter Griffin and his family of two teenagers, a smart dog, a devilish baby and his wife find themselves in some of the most hilarious scenarios.',
  small_cover_url: '/tmp/family_guy.jpg',
  large_cover_url: '/tmp/monk_large.jpg',
  category_id: 1
)

Video.create(
  title: 'Futurama',
  description: 'Accidentally frozen, pizza-deliverer Fry wakes up 1,000 years in the future. He is taken in by his sole descendant, an elderly and addled scientist who owns a small cargo delivery service. Among the other crew members are Capt. Leela, accountant Hermes, intern Amy, obnoxious robot Bender and lobsterlike moocher "Dr." Zoidberg.',
  small_cover_url: '/tmp/futurama.jpg',
  large_cover_url: '/tmp/monk_large.jpg',
  category_id: 1
)

Video.create(
  title: 'Monk',
  description: 'Former cop Adrian Monk was a star officer till he develops an obsessive-compulsive disorder. Now he struggles with simple everyday tasks but continues to investigate cases.',
  small_cover_url: '/tmp/monk.jpg',
  large_cover_url: '/tmp/monk_large.jpg',
  category_id: 2
)

Video.create(
  title: 'South Park',
  description: 'Follow the adventures of four young, schoolgoing boys, Stan Marsh, Kyle Broflovski, Eric Cartman and Kenny McCormick, who live in South Park.',
  small_cover_url: '/tmp/south_park.jpg',
  large_cover_url: '/tmp/monk_large.jpg',
  category_id: 1
)

Video.create(
  title: 'Family Guy',
  description: 'Peter Griffin and his family of two teenagers, a smart dog, a devilish baby and his wife find themselves in some of the most hilarious scenarios.',
  small_cover_url: '/tmp/family_guy.jpg',
  large_cover_url: '/tmp/monk_large.jpg',
  category_id: 1
)

Video.create(
  title: 'Futurama',
  description: 'Accidentally frozen, pizza-deliverer Fry wakes up 1,000 years in the future. He is taken in by his sole descendant, an elderly and addled scientist who owns a small cargo delivery service. Among the other crew members are Capt. Leela, accountant Hermes, intern Amy, obnoxious robot Bender and lobsterlike moocher "Dr." Zoidberg.',
  small_cover_url: '/tmp/futurama.jpg',
  large_cover_url: '/tmp/monk_large.jpg',
  category_id: 1
)

monk = Video.create(
  title: 'Monk',
  description: 'Former cop Adrian Monk was a star officer till he develops an obsessive-compulsive disorder. Now he struggles with simple everyday tasks but continues to investigate cases.',
  small_cover_url: '/tmp/monk.jpg',
  large_cover_url: '/tmp/monk_large.jpg',
  category_id: 2
)

Video.create(
  title: 'South Park',
  description: 'Follow the adventures of four young, schoolgoing boys, Stan Marsh, Kyle Broflovski, Eric Cartman and Kenny McCormick, who live in South Park.',
  small_cover_url: '/tmp/south_park.jpg',
  large_cover_url: '/tmp/monk_large.jpg',
  category_id: 1
)

Video.create(
  title: 'South Park',
  description: 'Follow the adventures of four young, schoolgoing boys, Stan Marsh, Kyle Broflovski, Eric Cartman and Kenny McCormick, who live in South Park.',
  small_cover_url: '/tmp/south_park.jpg',
  large_cover_url: '/tmp/monk_large.jpg',
  category_id: 1
)

akshat = User.create(full_name: 'Akshat Kedia', password: 'password', email: 'kevin@example.com')

Review.create(
  user: akshat,
  video: monk,
  rating: 5,
  content: 'This is a really good movie!'
)

Review.create(
  user: akshat,
  video: monk,
  rating: 2,
  content: 'This is a really horrible movie!'
)
