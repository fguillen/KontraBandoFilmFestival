class Front::ShortFilmUsersController < Front::FrontController
  def index
    @short_film_users = ShortFilmUser.all
  end

  def show
    @short_film_user = ShortFilmUser.find(params[:id])
  end
end
