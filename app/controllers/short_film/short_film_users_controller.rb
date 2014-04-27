class ShortFilm::ShortFilmUsersController < ShortFilm::ShortFilmController
  before_filter :require_short_film_user, :only => [:show, :edit, :update, :destroy]
  before_filter :load_short_film_user, :only => [:show, :edit, :update, :destroy]
  before_filter :require_short_film_user_to_be_the_one_logged, :only => [:show, :edit, :update, :destroy]

  def show
    @alerts = []
    @alerts << t("controllers.short_films.show.alert_not_paid", :pay_link => pay_short_film_online_purchases_path) if !@short_film_user.paid_at?
    @alerts << t("controllers.short_films.show.alert_not_received", :instructions_link => front_page_path("send_short_film")) if !@short_film_user.received_at?
    @alerts << t("controllers.short_films.show.alert_not_moderation_accepted") if !@short_film_user.moderation_accepted?
  end

  def new
    @short_film_user = ShortFilmUser.new
  end

  def create
    @short_film_user = ShortFilmUser.new(params[:short_film_user])
    @short_film_user.log_book_historian = @short_film_user
    if @short_film_user.save
      redirect_to short_film_login_path, :notice => t("controllers.short_films.create.success")
    else
      flash.now[:alert] = t("controllers.short_films.create.error")
      render :action => 'new'
    end
  end

  def edit
  end

  def update
    @short_film_user.log_book_historian = @short_film_user
    if @short_film_user.update_attributes(params[:short_film_user])
      @short_film_user.update_attributes!(:moderation_accepted => false)
      redirect_to [:short_film, @short_film_user], :notice  => t("controllers.short_films.update.success")
    else
      flash.now[:alert] = t("controllers.short_films.update.error")
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
      flash[:notice] = t("controllers.short_films.reset_password.success")
      redirect_back_or_default [:short_film, @short_film_user]
    else
      flash.now[:alert] = t("controllers.short_films.reset_password.error")
      render :reset_password
    end
  end

private

  def load_short_film_user
    @short_film_user = ShortFilmUser.find(params[:id])
  end
end
