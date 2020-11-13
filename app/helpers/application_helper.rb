module ApplicationHelper

  # include
  include ActionView::Helpers::TagHelper
  include ActionView::Context

  # error messageを出力するメソッド keyはカラム名,readingは画面に表示する名前
  def display_validation_errors(key,reading)
    unless flash[key].nil?
      unless flash[key].empty?

        html = "<div class='flash-message'>"
        flash[key].each do |message|
          html += "<div class='#{key}'>#{reading}#{message}</div>"
        end
        html += "</div>"
        
        return html.html_safe
      end
    end
  end

end
