class Song < ActiveRecord::Base
  attr_accessible :title, :authors, :record_year, :lyrics, :music_papers

  validates :title, :authors, :lyrics, presence: true

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      song = find_by_id(row["id"]) || new
      song.attributes = row.to_hash.slice(*accessible_attributes)
      song.save!
    end
  end
end
