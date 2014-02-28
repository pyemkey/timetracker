module ApplicationHelper

  def nav_items
    [
      {
        display_text: "Companies",
        controller_name: "companies",
        url_path: companies_path },
      {
        display_text: "Projects",
        controller_name: "projects",
        url_path: projects_path },
      {
        display_text: "Works",
        controller_name: "works",
        url_path: works_path }
    ]
  end

  def display_nav_item(display_text, controller_name_p, url_path)
    raw("<li #{controller_name == controller_name_p ? 'class="active"' : ''}>#{link_to display_text, url_path}</li>")
  end
end
