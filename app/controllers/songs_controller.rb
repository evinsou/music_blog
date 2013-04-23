class SongsController < ApplicationController
  before_filter :authenticate, :except => [:index, :show]
  respond_to :html, :js
  def index
    @songs = Song.all
    respond_with @songs
  end
  def show
    @song = Song.find(params[:id])
  end
  def new
    @song = Song.new
    respond_with @song
  end
  def create
    @song = Song.new(params[:song])
    if @song.save
      redirect_to songs_path
    else
      render action: 'new'
    end
  end
  def edit
    @song = Song.find(params[:id])
    respond_with @song
  end
  def update
    @song = Song.find(params[:id])
    if @song.update_attributes(params[:song])
      redirect_to songs_path
    else
      render action: 'edit'
    end
  end
  def destroy
    @song = Song.find(params[:id])
    redirect_to songs_path
  end
end
