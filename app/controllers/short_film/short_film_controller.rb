class ShortFilm::ShortFilmController < ApplicationController
  include ShortFilm::ShortFilmHelper

  layout "/front/front"

  helper_method :current_short_film_user, :namespace

  private

  def require_short_film_user
    unless current_short_film_user
      store_location
      flash[:alert] = "You need to be authenticated to acccess this page"
      redirect_to short_film_login_path
      return false
    end
  end

  def current_short_film_user_session
    return @current_short_film_user_session if defined?(@current_short_film_user_session)
    @current_short_film_user_session = ShortFilmUserSession.find
  end

  def current_short_film_user
    return @current_short_film_user if defined?(@current_short_film_user)
    @current_short_film_user = current_short_film_user_session && current_short_film_user_session.record
  end

  def store_location
    session[:return_to_short_film] = request.url
  end

  def redirect_back_or_default( default )
    redirect_to(session[:return_to] || default)
    session[:return_to_short_film] = nil
  end
end