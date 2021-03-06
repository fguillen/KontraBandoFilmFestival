require "test_helper"

class Front::ShortFilmUsersControllerTest < ActionController::TestCase
  def test_index
    short_film_user_1 = FactoryGirl.create(:short_film_user, :moderation_accepted => false)
    short_film_user_2 = FactoryGirl.create(:short_film_user, :moderation_accepted => true)
    short_film_user_3 = FactoryGirl.create(:short_film_user, :moderation_accepted => true)

    get :index

    assert :success
    assert_template "front/short_film_users/index"
    assert_equal([short_film_user_2, short_film_user_3].ids, assigns(:short_film_users).ids)
  end

  def test_show
    short_film_user = FactoryGirl.create(:short_film_user, :moderation_accepted => true)

    get :show, :id => short_film_user

    assert :success
    assert_template "front/short_film_users/show"
    assert_equal(short_film_user, assigns(:short_film_user))
  end
end
