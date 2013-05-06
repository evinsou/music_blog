ActiveAdmin.register Feedback do
  scope :published
  scope :not_published
  #batch_action :publish do |selection|
  #  Feedback.find(selection).each do |feedback|
  #    feedback.publish
  #  end
  #end
  member_action :publish, :method => :put do
    feedback = Feedback.find(params[:id])
    feedback.update_attributes :published => true
    redirect_to admin_feedbacks_path(:order=>:id_desc, :page=>1, :scope=> :not_published)
  end
  collection_action :not_published do
    feedbacks = Feedback.where :published => false
  end
  index do
    selectable_column
    column :name
    column :body
    column :location
    column :created_at
    column :publish, :sortable => :publish do |feedback|
      link_to 'publish', publish_admin_feedback_path(feedback), :method => :put
    end
    default_actions
  end
end
