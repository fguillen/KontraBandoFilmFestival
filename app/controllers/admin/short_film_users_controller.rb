class Admin::ShortFilmUsersController < Admin::AdminController
  before_filter :require_admin_user
  before_filter :load_short_film_user, :only => [:show, :edit, :update, :destroy, :log_book_events]

  def index
    @short_film_users = ShortFilmUser.all
  end

  def show
  end

  def new
    @short_film_user = ShortFilmUser.new
  end

  def create
    @short_film_user = ShortFilmUser.new(params[:short_film_user])
    @short_film_user.log_book_historian = current_admin_user
    if @short_film_user.save
      redirect_to [:admin, @short_film_user], :notice => "Successfully created ShortFilmUser."
    else
      flash.now[:alert] = "Some error trying to create short_film_user."
      render :action => 'new'
    end
  end

  def edit
  end

  def update
    @short_film_user.log_book_historian = current_admin_user
    if @short_film_user.update_attributes(params[:short_film_user])
      redirect_to [:admin, @short_film_user], :notice  => "Successfully updated ShortFilmUser."
    else
      flash.now[:alert] = "Some error trying to update ShortFilmUser."
      render :action => 'edit'
    end
  end

  def destroy
    @short_film_user.log_book_historian = current_admin_user
    @short_film_user.destroy
    redirect_to :admin_short_film_users, :notice => "Successfully destroyed ShortFilmUser."
  end

  def reorder
    params[:ids].each_with_index do |id, index|
      ShortFilmUser.update_all(["position=?", index], ["id=?", id])
    end
    render :json => { "status" => "ok" }
  end

  def log_book_events
    @log_book_events = @short_film_user.log_book_events.by_recent.paginate(:page => params[:page], :per_page => 10)
  end

private

  def load_short_film_user
    @short_film_user = ShortFilmUser.find(params[:id])
  end
end
