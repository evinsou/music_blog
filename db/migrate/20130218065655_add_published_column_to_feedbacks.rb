class AddPublishedColumnToFeedbacks < ActiveRecord::Migration
  def change
    add_column :feedbacks, :published, :boolean, default: false
  end
end
