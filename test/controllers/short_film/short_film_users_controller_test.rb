require "test_helper"

class ShortFilm::ShortFilmUsersControllerTest < ActionController::TestCase
  def setup
    setup_short_film_user
  end

  def test_new
    get :new
    assert_template "short_film/short_film_users/new"
    assert_not_nil(assigns(:short_film_user))
  end

  def test_create_invalid
    ShortFilmUser.any_instance.stubs(:valid?).returns(false)

    post :create

    assert_template "new"
    assert_not_nil(flash[:alert])
  end

  def test_create_valid
    short_film_user_attributes = FactoryGirl.attributes_for(:short_film_user, :title => "The Title", :thumbnail => fixture_file_upload("/pic.jpg"))

    post(
      :create,
      :short_film_user => short_film_user_attributes
    )

    short_film_user = ShortFilmUser.last
    assert_redirected_to [:short_film, short_film_user]

    assert_equal("The Title", short_film_user.title)
    assert_match("front.jpg", short_film_user.thumbnail.url(:front))
  end

  def test_edit
    short_film_user = FactoryGirl.create(:short_film_user)

    get :edit, :id => short_film_user

    assert_template "edit"
    assert_equal(short_film_user, assigns(:short_film_user))
  end

  def test_update_invalid
    short_film_user = FactoryGirl.create(:short_film_user)
    ShortFilmUser.any_instance.stubs(:valid?).returns(false)

    put :update, :id => short_film_user

    assert_template "edit"
    assert_not_nil(flash[:alert])
  end

  def test_update_valid
    short_film_user = FactoryGirl.create(:short_film_user)

    put(
      :update,
      :id => short_film_user,
      :short_film_user => {
        :title => "Other Title"
      }
    )

    short_film_user.reload
    assert_redirected_to [:short_film, short_film_user]
    assert_not_nil(flash[:notice])

    short_film_user.reload
    assert_equal("Other Title", short_film_user.title)
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
end
