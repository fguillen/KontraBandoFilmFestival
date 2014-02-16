require "test_helper"

class ShortFilmUserTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert FactoryGirl.create(:short_film_user).valid?
  end

  def test_duration
    short_film_user = FactoryGirl.create(:short_film_user, :length_minutes => 1, :length_seconds => 2)
    assert_equal("01:02", short_film_user.duration)

    short_film_user = FactoryGirl.create(:short_film_user, :length_minutes => 100, :length_seconds => 20)
    assert_equal("100:20", short_film_user.duration)
  end

  def test_previous
    short_film_user_1 = FactoryGirl.create(:short_film_user)
    short_film_user_2 = FactoryGirl.create(:short_film_user)

    assert_equal(nil, short_film_user_1.previous)
    assert_equal(short_film_user_1.id, short_film_user_2.previous.id)
  end

  def test_next
    short_film_user_1 = FactoryGirl.create(:short_film_user)
    short_film_user_2 = FactoryGirl.create(:short_film_user)

    assert_equal(short_film_user_2.id, short_film_user_1.next.id)
    assert_equal(nil, short_film_user_2.next)
  end
end
