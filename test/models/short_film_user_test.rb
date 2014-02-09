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
end
