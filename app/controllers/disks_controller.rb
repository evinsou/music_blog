class DisksController < ApplicationController
  before_filter :authenticate, :except => [:index]
  respond_to :html, :js
  def index
    @disks = Disk.all
    respond_with @disks
  end
  def new
    @disk = Disk.new
    respond_with @disk
  end
  def create
    @disk = Disk.new(params[:disk])
    if @disk.save
      redirect_to disks_path
    else
      render action: 'new'
    end
  end
  def edit
    @disk = Disk.find(params[:id])
    respond_with @disk
  end
  def update
    @disk = Disk.find(params[:id])
    if @disk.update_attributes(params[:disk])
      redirect_to disks_path
    else
      render action: 'edit'
    end
  end
  def destroy
    @disk = Disk.find(params[:id])
    redirect_to disks_path
  end
end
