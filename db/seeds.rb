User.create( email: "sample@gmail.com", member: true, admin: true, password: "password")

PRODUCT_ARRAY = [ "cap-boy", "cart-dash", "cuple", "drink-coffee", "matilda", "ride-bike", "see-back", "sitdown", "yoda"]

PRODUCT_ARRAY.each do |image_name|
  product = Product.new( 
    name: image_name, 
    detail: "#{image_name} detail", 
    price: 9999
  )
  product.image.attach(io: File.open("app/assets/images/#{image_name}.jpg"), filename: "#{image_name}.jpg")
  product.save!
end