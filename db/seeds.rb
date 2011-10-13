user1 = User.find_or_create_by_name("Billy B")
user2 = User.find_or_create_by_name("Jenny J")
user3 = User.find_or_create_by_name("Kara K")

Avatar.create(:user => user1,
              :small_url => "/assets/dfp/small.jpg",
              :medium_url => "/assets/dfp/medium.jpg",
              :large_url => "/assets/dfp/large.jpg")

Avatar.create(:user => user2,
              :small_url => "/assets/rails.png",
              :medium_url => "/assets/rails.png",
              :large_url => "/assets/rails.png")

Avatar.create(:user => user3,
              :small_url => "/assets/dfp/small.jpg",
              :medium_url => "/assets/dfp/medium.jpg",
              :large_url => "/assets/dfp/large.jpg")
