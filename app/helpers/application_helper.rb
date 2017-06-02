module ApplicationHelper
  require 'redcarpet'
  require 'coderay'

  class HtmlRendererWithCoderay < Redcarpet::Render::HTML
    def block_code(code, language)
      language = language.split(':')[0]
      language = case language.to_s
      when 'rb'
        'ruby'
      when 'yml'
        'yaml'
      when 'css'
        'css'
      when 'html'
        'html'
      when ''
        'md'
      else
        language
      end

      CodeRay.scan(code, language).div
    end
  end

  def markdown(text)
    html_render = HtmlRendererWithCoderay.new(filter_html: true, hard_wrap: true)
    options = {
      autolink: false,
      space_after_headers: true,
      no_intra_emphasis: true,
      fenced_code_blocks: true,
      tables: true,
      hard_wrap: true,
      xhtml: false,
      lax_html_blocks: true,
      strikethrough: true
    }
    markdown = Redcarpet::Markdown.new(html_render, options)
    markdown.render(text)
  end
end
