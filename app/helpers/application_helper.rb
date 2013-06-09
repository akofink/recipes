module ApplicationHelper
  def md(text)
    Redcarpet::Markdown.new(
      Redcarpet::Render::HTML,
      autolink: true,
      space_after_headers: true,
      no_intra_emphasis: true,
      with_toc_data: true
    ).render(text).html_safe
  end
end
