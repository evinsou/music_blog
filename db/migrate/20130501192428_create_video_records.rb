class CreateVideoRecords < ActiveRecord::Migration
  def change
    create_table :video_records do |t|
      t.string :title
      t.string :youtube_url
      t.timestamps
    end
  end
end
