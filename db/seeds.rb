# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


ActiveRecord::Base.transaction do
  brand = Brand.create({name: "McDonald's"})

  brand.outlets.create({name: "Subang Jaya", password: "mcdonaldsubangjaya"})

  brand.promotions.create({title: "Free Sundae", 
                       description: "Get a free sundae",
                       cost: 100 
  })

  brand.promotions.create({title: "Free Happy Meal", 
                       description: "Get a free burger with drinks and fries",
                       cost: 200
  })
end
