module Admin::AdminHelper
  include ApplicationHelper

  def twitterized_type(type)
    case type
      when :alert
        "alert alert-danger"
      when :notice
        "alert alert-success"
      else
        type.to_s
    end
  end

  def admin_menu_class(actual_menu_name)
    menus = {
      :admin_users => ["/admin/admin_users.*"],
      :short_film_users => ["/admin/short_film_users.*", "/admin"],
      :log_book_events => ["/admin/log_book_events"],
      :short_film_user_log_book_events => ["/admin/short_film_users/.+/log_book_events"],
      :short_film_user_info => ["/admin/short_film_users/[^/]+"]
    }

    menu_class(menus, actual_menu_name)
  end

  def render_label(word, palette_name)
    StylePalette::Helper.label(word, palette_name).html_safe
  end

  def render_labels(words, palette_name)
    words.map { |e| render_label e, palette_name }.join(" ").html_safe
  end
end
