module ElementsHelper
  def render_element(el, *opts)
    render("layouts/web/elements/" + el, *opts)
  end

  def quotes_to_html(str)
    str.gsub(/"([^"]*)"/, '<q>\1</q>')
  end
end
