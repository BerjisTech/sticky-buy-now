class WidgetappController < ActionController::Base
  def javascript
    redirect_to ActionController::Base.helpers.javascript_path("sticky-buy-now-button.js")
  end
  def css
    redirect_to ActionController::Base.helpers.stylesheet_path("sticky-buy-now-button.css")
  end
end
