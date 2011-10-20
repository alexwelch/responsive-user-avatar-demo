user1 = User.find_or_create_by_name("Billy B")
user2 = User.find_or_create_by_name("Jenny J")
user3 = User.find_or_create_by_name("Kara K")

Avatar.destroy_all
Avatar.create(:user => user1,
              :small_path => "app/assets/images/dfp/small.jpg",
              :medium_path => "app/assets/images/dfp/medium.jpg",
              :large_path => "app/assets/images/dfp/large.jpg")

Avatar.create(:user => user2,
              :small_path => "app/assets/images/mono_cat/small.jpg",
              :medium_path => "app/assets/images/mono_cat/medium.jpg",
              :large_path => "app/assets/images/mono_cat/large.jpg")

Avatar.create(:user => user3,
              :small_path => "app/assets/images/rails.png",
              :medium_path => "app/assets/images/rails.png",
              :large_path => "app/assets/images/rails.png")
