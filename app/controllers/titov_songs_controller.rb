class TitovSongsController < ApplicationController
  layout 'main_page'
  def index
    @titov_songs = TitovSong.all
  end

  def show
    @titov_song = TitovSong.find(params[:id])
  end
end
