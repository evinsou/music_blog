class ChangeDataTypeForBodyInFeedbacks < ActiveRecord::Migration
  def up
    change_table :feedbacks do |t|
      t.change :body, :text
    end
  end

  def down
    change_table :feedbacks do |t|
      t.change :body, :string
    end
  end
end
