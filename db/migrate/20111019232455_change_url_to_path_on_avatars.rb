class ChangeUrlToPathOnAvatars < ActiveRecord::Migration
  def change
    rename_column :avatars, :small_url, :small_path
    rename_column :avatars, :medium_url, :medium_path
    rename_column :avatars, :large_url, :large_path
  end
end
