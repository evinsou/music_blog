class CreateDisks < ActiveRecord::Migration
  def change
    create_table :disks do |t|
      t.string :title
      t.text :body
      t.string :year
      t.string :album_cover
      t.timestamps
    end
  end
end
