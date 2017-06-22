# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Cat.destroy_all

cat1 = Cat.create!(birth_date: "2014/01/12", color: "Brown tabby", age: 3, sex: "M", name: "George", description: "A cool cat")
cat2 = Cat.create!(birth_date: "2012/01/12", color: "Black", age: 5, sex: "M", name: "Fido", description: "A cool cat")
cat3 = Cat.create!(birth_date: "2010/01/12", color: "Brown", age: 7, sex: "M", name: "Tiger", description: "A cool cat")
cat4 = Cat.create!(birth_date: "2008/01/12", color: "Seal point", age: 9, sex: "M", name: "Paws", description: "A cool cat")
cat5 = Cat.create!(birth_date: "2009/01/12", color: "Blue point", age: 8, sex: "F", name: "Frosty", description: "A cool cat")
cat6 = Cat.create!(birth_date: "2011/01/12", color: "Cinnamon", age: 6, sex: "M", name: "Ginger", description: "A cool cat")
cat7 = Cat.create!(birth_date: "2009/01/25", color: "Marmalade", age: 8, sex: "F", name: "George jr.", description: "A cool cat")


catrequest1 = CatRentalRequest.create!(cat_id: 1, start_date: "2017/06/25", end_date: "2017/06/30")
catrequest2 = CatRentalRequest.create!(cat_id: 1, start_date: "2017/06/25", end_date: "2017/06/30", status: "Approved")
catrequest3 = CatRentalRequest.create!(cat_id: 3, start_date: "2017/06/25", end_date: "2017/06/30", status: "Denied")
