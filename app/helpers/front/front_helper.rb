module Front::FrontHelper
  def front_menu_class(actual_menu_name)
    menus = {
      :pages_home => ["/", "/front/pages/home"],
      :pages_about => ["/front/pages/about"],
      :short_film_users_new => ["/short_film/short_film_users/new"],
      :short_film_users => ["/front/short_film_users.*"],
      :log_book_events => ["/admin/log_book_events"],
      :short_film_user_log_book_events => ["/admin/short_film_users/.+/log_book_events"],
      :short_film_user_info => ["/admin/short_film_users/[^/]+"]
    }

    menu_class(menus, actual_menu_name)
  end
end
