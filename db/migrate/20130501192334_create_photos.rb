class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :title
      t.string :image_url
      t.string :small_photo
      t.timestamps
    end
  end
end
