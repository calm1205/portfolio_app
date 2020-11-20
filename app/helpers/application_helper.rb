module ApplicationHelper

  # include
  include ActionView::Helpers::TagHelper
  include ActionView::Context

  # error messageを出力するメソッド keyはカラム名,readingは画面に表示する名前
  def display_validation_errors(key,reading)
    unless flash[key].nil?
      unless flash[key].empty?

        # エラーメッセージのHTMLを作成
        html = "<div class='flash-message'>"
        if flash[key].kind_of?(String) #flashメッセージが1つだとString型になる。
          html += "<div class='#{key}'>#{reading}#{message}</div></div>"
        else #flashメッセージが複数あると配列になる。
          flash[key].each do |message|
            html += "<div class='#{key}'>#{reading}#{message}</div>"
          end
          html += "</div>"
        end
        
        return html.html_safe
      end
    end
  end

end
