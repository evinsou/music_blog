 # encoding: UTF-8
class MessagesController < ApplicationController
  before_filter :authenticate, except: [:new, :create]
  respond_to :html, :js
  def index
    @messages = Message.all
    respond_with @messages
  end
  def new
    @message = Message.new
    respond_with @message
  end
  def create
    @message = Message.new(params[:message])
    if @message.save
      redirect_to messages_path
    else
      render action: 'new'
    end
  end
  def edit
    @message = Message.find(params[:id])
    respond_with @message
  end
  def update
    @message = Message.find(params[:id])
    if @message.update_attributes(params[:message])
      redirect_to messages_path
    else
      render action: 'edit'
    end
  end
  def destroy
    @message = Message.find(params[:id])
    redirect_to messages_path
  end
end
