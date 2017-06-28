module ApplicationHelper
  def markdown(text)
    CustomMarkdown.render(text).html_safe
  end
end
