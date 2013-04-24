ActiveAdmin.register Feedback do
  scope :published
  scope :not_published
  index do
    column :name
    column :location
    column :body
    column :published
  end
end
