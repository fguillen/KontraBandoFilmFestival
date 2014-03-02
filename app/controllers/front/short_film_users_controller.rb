class Front::ShortFilmUsersController < Front::FrontController
  def index
    @short_film_users = ShortFilmUser.validated
  end

  def show
    @short_film_user = ShortFilmUser.validated.find(params[:id])
  end
end
