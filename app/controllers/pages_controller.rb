class PagesController < HighVoltage::PagesController
  #before_filter :authenticate
  layout :layout_for_page

  protected
    def layout_for_page
      case params[:id]
      when 'main_page'
        'main_page'
      else
        'application'
      end
    end
end
