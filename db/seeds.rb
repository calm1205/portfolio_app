User.create( 
  nickname: "super-user", 
  email: "sample@gmail.com", 
  member: true, 
  admin: true, 
  password: "Passw0rd"
)

Address.new(
  user_id: 1,
  last_name: "admin",
  first_name: "kun",
  last_name_reading: "admin",
  first_name_reading: "kun",
  postal_code: "123-4567",
  prefecture_id: 1,
  city: "Paris",
  house_number: "75007",
  building: "La tour Eiffel",
  phone_number: "33892701239"
).save(validate: false)

PRODUCT_ARRAY = [ "cap-boy", "cart-dash", "cuple", "drink-coffee", "matilda", "ride-bike", "see-back", "sitdown", "yoda"]
# image = Image.new(src: File.open("app/assets/images/cap-boy.jpg"))
# product = Product.new(name: 'sample', detail: 'detail text', price: 999, stock: 99)
# product.images << image

PRODUCT_ARRAY.each do |image_name|

  image = Image.new(
    src: File.open("app/assets/images/#{image_name}.jpg")
  )
  product = Product.new( 
    name: image_name, 
    detail: "#{image_name} detail", 
    price: 9999,
    stock: 99
  )

  product.images << image

  # This is for Active Storage
  # product.image.attach(io: File.open("app/assets/images/#{image_name}.jpg"), filename: "#{image_name}.jpg")
  product.save!
end