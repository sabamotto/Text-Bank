require 'redcarpet'
require 'coderay'

module CustomMarkdown
  class << self
    def render(*args)
      shared_markdown.render(*args).html_safe
    end

    def shared_markdown
      @@shared_markdown ||= Redcarpet::Markdown.new(
        shared_renderer,
        autolink: false,
        space_after_headers: true,
        no_intra_emphasis: true,
        fenced_code_blocks: true,
        tables: true,
        hard_wrap: true,
        xhtml: false,
        lax_html_blocks: true,
        strikethrough: true
      )
    end

    def shared_renderer
      @@shared_renderer ||= HtmlRendererWithCoderay.new(
        filter_html: true,
        hard_wrap: true
      )
    end
  end

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
      when 'htm'
        'html'
      when ''
        'md'
      else
        language
      end

      CodeRay.scan(code, language).div
    end
  end
end
