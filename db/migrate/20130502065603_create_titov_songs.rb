class CreateTitovSongs < ActiveRecord::Migration
  def change
    create_table :titov_songs do |t|
      t.string :title
      t.string :song_length
      t.string :authors
      t.string :url_to_mp3
      t.timestamps
    end
  end
end
