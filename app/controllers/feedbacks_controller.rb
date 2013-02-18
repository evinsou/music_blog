class FeedbacksController < ApplicationController
  respond_to :html, :js
  def index
    @feedback = Feedback.new
    @feedbacks = Feedback.published
    respond_with @feedbacks
  end
  def create
    @feedback = Feedback.new(params[:feedback])
    if @feedback.save
      redirect_to feedbacks_path, :notice => 'Feedback created'
    else
      render action: 'new'
    end
  end
  def edit
    @feedback = Feedback.find(params[:id])
    respond_with @feedback
  end
  def update
    @feedback = Feedback.find(params[:id])
    if @feedback.update_attributes(params[:feedback])
      redirect_to feedbacks_path, :notice => 'Feedback updated'
    else
      render action: 'edit'
    end
  end
  def destroy
    @feedback = Feedback.find(params[:id])
    redirect_to feedbacks_path, :notice => 'Feedback deleted'
  end
  def publish
    @feedback = Feedback.find(params[:id])
    @feedback.update_attributes :is_published => true
    flash[:notice] = 'feedback is published'
    redirect_to not_published_feedbacks_path
  end
  def not_published
    @feedbacks = Feedback.not_published
  end
end
