require "test_helper"

class Admin::ShortFilmUsersControllerTest < ActionController::TestCase
  def setup
    setup_admin_user
  end

  def test_index
    short_film_user_1 = FactoryGirl.create(:short_film_user)
    short_film_user_2 = FactoryGirl.create(:short_film_user)

    get :index

    assert_template "admin/short_film_users/index"
    assert_equal([short_film_user_1, short_film_user_2].ids, assigns(:short_film_users).ids)
  end

  def test_show
    short_film_user = FactoryGirl.create(:short_film_user)

    get :show, :id => short_film_user

    assert_template "admin/short_film_users/show"
    assert_equal(short_film_user, assigns(:short_film_user))
  end

  def test_new
    get :new
    assert_template "admin/short_film_users/new"
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
    assert_redirected_to [:admin, short_film_user]

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

    assert_redirected_to [:admin, short_film_user]
    assert_not_nil(flash[:notice])

    assert_equal("Other Title", short_film_user.title)
  end

  def test_destroy
    short_film_user = FactoryGirl.create(:short_film_user)

    delete :destroy, :id => short_film_user

    assert_redirected_to :admin_short_film_users
    assert_not_nil(flash[:notice])

    assert !ShortFilmUser.exists?(short_film_user.id)
  end

  def test_log_book_events
    short_film_user = FactoryGirl.create(:short_film_user)
    short_film_user.log_book_events << FactoryGirl.create(:log_book_event)

    get :log_book_events, :id => short_film_user

    assert_template "log_book_events"
  end
end
