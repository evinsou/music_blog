class VideoRecordsController < ApplicationController
  def index
    @video_records = VideoRecord.all
  end
end
