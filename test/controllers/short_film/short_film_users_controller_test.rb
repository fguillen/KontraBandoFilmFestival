require "test_helper"

class ShortFilm::ShortFilmUsersControllerTest < ActionController::TestCase
  def setup
  end

  def test_show
    setup_short_film_user

    get :show, :id => @short_film_user

    assert_template "short_film/short_film_users/show"
    assert_not_nil(assigns(:short_film_user))
  end

  def test_show_not_allow_show_from_other_user
    setup_short_film_user
    other_short_film_user = FactoryGirl.create(:short_film_user)

    assert_raise(ActionController::RoutingError) do
      get :show, :id => other_short_film_user
    end
  end

  def test_on_show_show_alerts
    setup_short_film_user


    @short_film_user.update_attributes!(:moderation_accepted => false, :paid_at => nil, :received_at => nil)
    flash[:alert] = nil
    get :show, :id => @short_film_user
    assert_match(I18n.t("controllers.short_films.show.alert_not_paid"), flash[:alert])
    assert_match(I18n.t("controllers.short_films.show.alert_not_received"), flash[:alert])
    assert_match(I18n.t("controllers.short_films.show.alert_not_moderation_accepted"), flash[:alert])

    @short_film_user.update_attributes!(:moderation_accepted => false, :paid_at => Time.now, :received_at => Time.now)
    flash[:alert] = nil
    get :show, :id => @short_film_user
    assert_no_match(I18n.t("controllers.short_films.show.alert_not_paid"), flash[:alert])
    assert_no_match(I18n.t("controllers.short_films.show.alert_not_received"), flash[:alert])
    assert_match(I18n.t("controllers.short_films.show.alert_not_moderation_accepted"), flash[:alert])

    @short_film_user.update_attributes!(:moderation_accepted => true, :paid_at => Time.now, :received_at => Time.now)
    flash[:alert] = nil
    get :show, :id => @short_film_user
    assert_nil(flash[:alert])
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
    assert_redirected_to short_film_login_path

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

    assert_redirected_to [:short_film, @short_film_user]
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
