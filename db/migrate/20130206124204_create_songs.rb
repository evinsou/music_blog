class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :title
      t.string :authors
      t.string :record_year
      t.text   :lyrics
      t.string :music_papers
      t.timestamps
    end
  end
end
