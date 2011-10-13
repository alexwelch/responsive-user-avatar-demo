class CreateAvatars < ActiveRecord::Migration
  def change
    create_table :avatars do |t|
      t.references :user
      t.string :small_url
      t.string :medium_url
      t.string :large_url
      t.timestamps
    end
  end
end
