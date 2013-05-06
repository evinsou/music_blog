class AddRecordUrlToSongs < ActiveRecord::Migration
  def change
    add_column :songs, :record_url, :string
  end
end
