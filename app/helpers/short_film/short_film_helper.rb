module ShortFilm::ShortFilmHelper
  include ApplicationHelper

  def short_film_menu_class(actual_menu_name)
    menus = {
    }

    menu_class(menus, actual_menu_name)
  end
end
