require "test_helper"

class ShortFilm::ShortFilmUsersControllerTest < ActionController::TestCase
  def setup
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

    assert_not_nil(flash[:notice])

    short_film_user = ShortFilmUser.last
    assert_redirected_to [:front, short_film_user]

    assert_equal("The Title", short_film_user.title)
    assert_match("front.jpg", short_film_user.thumbnail.url(:front))
  end

  def test_edit
    setup_short_film_user

    get :edit, :id => @short_film_user

    assert_template "edit"
    assert_equal(@short_film_user, assigns(:short_film_user))
  end

  def test_update_invalid
    setup_short_film_user

    ShortFilmUser.any_instance.stubs(:valid?).returns(false)

    put :update, :id => @short_film_user

    assert_template "edit"
    assert_not_nil(flash[:alert])
  end

  def test_update_valid
    setup_short_film_user

    put(
      :update,
      :id => @short_film_user,
      :short_film_user => {
        :title => "Other Title"
      }
    )

    @short_film_user.reload

    assert_redirected_to [:front, @short_film_user]
    assert_not_nil(flash[:notice])

    assert_equal("Other Title", @short_film_user.title)
  end

  def test_after_update_make_moderation_accepted_false
    setup_short_film_user
    @short_film_user.update_attributes!(:moderation_accepted => true)

    put(
      :update,
      :id => @short_film_user,
      :short_film_user => {}
    )

    @short_film_user.reload
    assert_equal(false, @short_film_user.moderation_accepted)
  end

end
