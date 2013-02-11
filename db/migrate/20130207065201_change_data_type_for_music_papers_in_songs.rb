class ChangeDataTypeForMusicPapersInSongs < ActiveRecord::Migration
  def up
    change_table :songs do |t|
      t.change :music_papers, :text
    end
  end

  def down
    change_table :songs do |t|
      t.change :music_papers, :string
    end
  end
end
