# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

@store1 = Store.find_or_create_by(name: 'Central Santiago', city: 'Santiago', country: 'Chile', timezone: '-3', status: 1)
@store2 = Store.find_or_create_by(name: 'Central Isla', city: 'Isla Pascua', country: 'Chile', timezone: '-5', status: 1)

@user = User.find_or_create_by(email: 'gonzalo@tetracode.cl', password: "12345678")
@user.save
@user.add_role :god

@user = User.find_or_create_by(email: 'francisco@tetracode.cl', password: '12345678')
@user.save
@user.add_role :god

@user1 = User.find_or_create_by(email: 'admin@tetracode.cl', password: '12345678', store_id: @store1.id)
@user1.save
@user1.add_role :admin

@user = User.find_or_create_by(email: 'seller@tetracode.cl', password: '12345678', store_id: @store2.id)
@user.save
@user.add_role :seller

# Remove Role
#@user.remove_role :admin
