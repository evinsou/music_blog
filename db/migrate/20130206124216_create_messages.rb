class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :name
      t.string :location
      t.string :email
      t.text :body
      t.timestamps
    end
  end
end
