user1 = User.find_or_create_by_name("Billy B")
user2 = User.find_or_create_by_name("Jenny J")
user3 = User.find_or_create_by_name("Kara K")

Avatar.destroy_all
Avatar.create(:user => user1,
              :small_url => "dfp/small.jpg",
              :medium_url => "dfp/medium.jpg",
              :large_url => "dfp/large.jpg")

Avatar.create(:user => user2,
              :small_url => "mono_cat/small.jpg",
              :medium_url => "mono_cat/medium.jpg",
              :large_url => "mono_cat/large.jpg")

Avatar.create(:user => user3,
              :small_url => "rails.png",
              :medium_url => "rails.png",
              :large_url => "rails.png")
