class ShortFilm::ShortFilmUserSessionsController < ShortFilm::ShortFilmController
  def new
    @short_film_user_session = ShortFilmUserSession.new
  end

  def create
    @short_film_user_session = ShortFilmUserSession.new(params[:short_film_user_session])

    if @short_film_user_session.save
      flash[:notice] = "ShortFilm User authenticated!"
      redirect_back_or_default [:front, current_short_film_user]
    else
      flash[:alert] = "Not possible to authenticate"
      render action: "new"
    end
  end

  def destroy
    @short_film_user_session = ShortFilmUserSession.find
    @short_film_user_session.destroy if @short_film_user_session

    redirect_to short_film_login_path, :notice => "ShortFilm User logged out!"
  end

  def forgot_password
    @short_film_user_session = ShortFilmUserSession.new
  end

  def forgot_password_send_email
    short_film_user = ShortFilmUser.find_by_producer_email( params[:short_film_user_session][:producer_email] )

    if short_film_user
      short_film_user.send_reset_password_email
      redirect_to short_film_forgot_password_path, :notice => "Instructions to reset your password have been sent to your email"
    else
      redirect_to short_film_forgot_password_path, :alert => "We can't find the email '#{params[:short_film_user_session][:email]}'"
    end
  end
end