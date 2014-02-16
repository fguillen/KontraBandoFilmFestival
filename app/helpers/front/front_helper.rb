module Front::FrontHelper
  def front_menu_class(actual_menu_name)
    menus = {
      :pages_home => ["/", "/front/pages/home"],
      :pages_about => ["/front/pages/about"],
      :short_film_users => ["/front/short_film_users.*"]
    }

    menu_class(menus, actual_menu_name)
  end

  def riviera_box_class(type)
    case type
      when :alert
        "error_box"
      when :notice
        "success_box"
      else
        type.to_s
    end
  end
end
