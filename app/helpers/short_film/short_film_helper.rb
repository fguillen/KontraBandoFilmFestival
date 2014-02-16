module ShortFilm::ShortFilmHelper
  include ApplicationHelper

  def short_film_menu_class(actual_menu_name)
    menus = {
      :short_film_users_new => ["/short_film/short_film_users/new", "/short_film/short_film_users"],

    }

    menu_class(menus, actual_menu_name)
  end
end
