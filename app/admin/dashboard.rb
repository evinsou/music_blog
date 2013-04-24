ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => proc{ I18n.t("active_admin.dashboard") } do
    columns do
      column do
        panel "Recent Messages" do
          ul do
            Message.order('created_at DESC').limit(5).map do |message|
              li do
                span link_to(message.body, admin_message_path(message))
                span " by #{message.name}"
              end
            end
          end
        end
        panel "Recent Feedbacks" do
          ul do
            Feedback.order('created_at DESC').limit(5).collect do |feedback|
              li do
                span link_to(feedback.body, admin_feedback_path(feedback))
                span " #{feedback.name}"
              end
            end
          end
        end
      end
    end
    div do
      strong { link_to "View All Messages", admin_messages_path }
    end
    div do
      strong { link_to "View All Feedbacks", admin_feedbacks_path }
    end
  end # content
end
