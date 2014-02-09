require "test_helper"

class ShortFilm::ShortFilmUserSessionsControllerTest < ActionController::TestCase
  def test_should_get_new
    get :new
    assert_response :success
    assert_template "short_film/short_film_user_sessions/new"
  end

  def test_create
    short_film_user = FactoryGirl.create( :short_film_user )
    post(
      :create,
      :short_film_user_session => {
        :producer_email => short_film_user.producer_email,
        :password => short_film_user.password
      }
    )

    assert_redirected_to [:front, short_film_user]
    assert_not_nil( flash[:notice] )
  end

  def test_create_invalid
    post(
      :create,
      :short_film_user_session => {
        :producer_email => "email",
        :password => "password"
      }
    )

    assert_template "short_film/short_film_user_sessions/new"
    assert_not_nil( flash[:alert] )
  end

  def test_destroy
    delete :destroy
    assert_redirected_to short_film_login_path
    assert_not_nil( flash[:notice] )
  end

  def test_forgot_password
    get( :forgot_password )
    assert_template "short_film/short_film_user_sessions/forgot_password"
  end

  def test_forgot_password_send_email_with_no_valid_email
    post(
      :forgot_password_send_email,
      :short_film_user_session => {
        :producer_email => "not-exists"
      }
    )

    assert_redirected_to short_film_forgot_password_path
    assert_not_nil( flash[:alert] )
  end

  def test_forgot_password_send_email
    short_film_user = FactoryGirl.create( :short_film_user )
    ShortFilmUser.any_instance.expects( :send_reset_password_email )

    post(
      :forgot_password_send_email,
      :short_film_user_session => {
        :producer_email => short_film_user.producer_email
      }
    )

    assert_redirected_to short_film_forgot_password_path
    assert_not_nil( flash[:notice] )
  end
end
