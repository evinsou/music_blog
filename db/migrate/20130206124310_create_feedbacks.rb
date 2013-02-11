class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.string :name
      t.string :location
      t.string :body
      t.timestamps
    end
  end
end
