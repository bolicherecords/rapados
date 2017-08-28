# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

@user = User.find_or_create_by(email: "gonzalo@tetracode.cl", password: "12345678")
@user.save
@user.add_role :god

@user = User.find_or_create_by(email: "francisco@tetracode.cl", password: "12345678")
@user.save
@user.add_role :god

@user = User.find_or_create_by(email: "admin@tetracode.cl", password: "12345678")
@user.save
@user.add_role :admin

@user = User.find_or_create_by(email: "seller@tetracode.cl", password: "12345678")
@user.save
@user.add_role :seller

# Remove Role
#@user.remove_role :admin
