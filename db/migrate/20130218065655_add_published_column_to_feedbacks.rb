class AddPublishedColumnToFeedbacks < ActiveRecord::Migration
  def change
    add_column :feedbacks, :published, :boolean
  end
end
