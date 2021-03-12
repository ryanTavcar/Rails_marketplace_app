user_name = ['stacy', 'bill', 'todd', 'mike', 'alex', 'daniel', 'mia', 'lucy', 'emily', 'holly']
last_name = ['Garcia', 'Cooley', 'Colon', 'Rose', 'Galloway', 'King', 'Moran', 'Rivas', 'Yang', 'Cobb']
email = ['stacy@gmail.com', 'bill@gmail.com', 'todd@gmail.com', 'mike@gmail.com', 'alex@gmail.com', 'daniel@gmail.com', 'mia@gmail.com', 'lucy@gmail.com', 'emily@gmail.com', 'holly@gmail.com']
product_name = ['Glasses', 'Phone Holder', 'Figurine Skull', 'Cable Management', 'Zip Ties', 'Wall Hook', 'Vase', 'Pot Plant', 'Earphone Holer', 'Tablet Stand']
material = ['PLA', 'ABS', 'PVA']
material_id = [1,2,3]

if Material.count == 0
    material.each do |mat|
        Material.create!(name: mat)
        puts "created #{mat} material"
    end
end

if User.count == 0 && User.count <= 10
    user_plus = 0
    email.each do |email|
        user_plus = user_plus + 1
        User.create!(email: email, username: "@#{user_name.sample}" , password: '123456', password_confirmation: '123456')
        puts "created user #{user_plus}"
    end
end

if Product.count == 0 && Product.count <= 10
    user_plus = 0
    10.times.each do 
        user_plus = user_plus + 1
        Product.create!(
            name: product_name.sample, 
            like: rand(100), 
            description: 'This product was generated from db/seeds.rb', 
            price: rand(1..50), 
            material_id: rand(1..3),
            purchased: false,
            user_id: rand(10)
        )
        puts "created profile: #{Product.find_by(user_id: user_plus)}"
    end
end

if Profile.count == 0 && Profile.count <= 10
    user_plus = 0
    10.times.each do
        user_plus = user_plus + 1
        Profile.create!(
            user_id: user_plus, 
            biography: 'This profile was generated from db/seeds.rb',
            first_name: user_name.sample,
            last_name: last_name.sample
        )
        puts "created profile #{Profile.find_by(user_id: user_plus)}"
        
    end
end

