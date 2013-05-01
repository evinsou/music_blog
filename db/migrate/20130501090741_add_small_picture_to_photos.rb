class AddSmallPictureToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :small_picture, :string
  end
end
