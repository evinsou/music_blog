class CommentsController < ApplicationController
  respond_to :html, :js
  def index
    @comments = Comment.all
    respond_with @comments
  end
  def new
    @comment = Comment.new
    respond_with @comment
  end
  def create
    @comment = Comment.new(params[:comment])
  end
  def edit
    @comment = Comment.find(params[:id])
    respond_with @comment
  end
  def update
    @comment = Comment.find(params[:id])
  end
  def destroy
    @comment = Comment.find(params[:id])
  end
end
