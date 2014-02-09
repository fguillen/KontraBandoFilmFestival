class ShortFilm::ShortFilmUsersController < ShortFilm::ShortFilmController
  before_filter :require_short_film_user, :except => [:reset_password, :reset_password_submit]
  before_filter :load_short_film_user, :only => [:show, :edit, :update, :destroy]

  def new
    @short_film_user = ShortFilmUser.new
  end

  def create
    @short_film_user = ShortFilmUser.new(params[:short_film_user])
    if @short_film_user.save
      redirect_to [:short_film, @short_film_user], :notice => "Successfully created ShortFilmUser."
    else
      flash.now[:alert] = "Some error trying to create short_film_user."
      render :action => 'new'
    end
  end

  def edit
  end

  def update
    if @short_film_user.update_attributes(params[:short_film_user])
      redirect_to [:short_film, @short_film_user], :notice  => "Successfully updated ShortFilmUser."
    else
      flash.now[:alert] = "Some error trying to update ShortFilmUser."
      render :action => 'edit'
    end
  end

  def reset_password
    @short_film_user = ShortFilmUser.find_using_perishable_token!(params[:reset_password_code], 1.week)
  end

  def reset_password_submit
    @short_film_user = ShortFilmUser.find_using_perishable_token!(params[:reset_password_code], 1.week)

    if @short_film_user.update_attributes(params[:short_film_user])
      ShortFilmUserSession.create(@short_film_user)
      flash[:notice] = "Password reseted, you have been authenticated!"
      redirect_back_or_default short_film_root_path
    else
      flash.now[:alert] = "Some errors trying to reset the password"
      render :reset_password
    end
  end

private

  def load_short_film_user
    @short_film_user = ShortFilmUser.find(params[:id])
  end
end
