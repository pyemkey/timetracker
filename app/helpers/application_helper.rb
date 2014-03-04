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

  def display_login_messages
    if user_signed_in?
      raw("<p>#{current_user}<br/>#{link_to 'Logout', destroy_user_session_path, method: :delete, confirm: 'Are you sure?'} </p>")
    else
      #Login | Register

      raw("<p>#{link_to 'Login', new_user_session_path} | #{link_to 'Register', new_user_registration_path}</p>")
    end
  end
end
